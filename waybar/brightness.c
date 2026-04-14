#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

#define SHM_PATH "/dev/shm/waybar_br_val"
#define LOCK_PATH "/dev/shm/waybar_br_lock"

int read_val() {
    FILE *f = fopen(SHM_PATH, "r");
    int val = 50;
    if (f) {
        if (fscanf(f, "%d", &val) != 1) val = 50;
        fclose(f);
    }
    return val;
}

void write_val(int val) {
    FILE *f = fopen(SHM_PATH, "w");
    if (f) {
        fprintf(f, "%d", val);
        fclose(f);
    }
}

const char* get_icon(int val) {
    if (val <= 30) return "󰃞";
    if (val <= 70) return "󰃟";
    return "󰃠";
}

int main(int argc, char *argv[]) {
    int val;

    if (argc > 1) {
        val = read_val();

        if (strcmp(argv[1], "up") == 0) val += 1;
        else if (strcmp(argv[1], "down") == 0) val -= 1;

        if (val > 100) val = 100;
        if (val < 0) val = 0;

        write_val(val);

        // 1. UI always updates instantly
        printf("{\"text\":\"%s  %d%%\", \"percentage\":%d}\n", get_icon(val), val, val);
        fflush(stdout);

        // 2. Hardware Update Logic
        // If no lock exists, start the hardware update loop
        if (access(LOCK_PATH, F_OK) == -1) {
            char cmd[1024];
            // This loop runs in the background. It checks if the current
            // hardware brightness matches the RAM value. If not, it updates it.
            // This ensures the "final" scroll position is always reached.
            snprintf(cmd, sizeof(cmd),
                     "(touch %s; "
                     "last=-1; "
                     "while true; do "
                     "  current=$(cat %s); "
                     "  if [ \"$current\" = \"$last\" ]; then break; fi; "
                     "  ddcutil setvcp 10 $current --bus 0 --noverify; "
                     "  last=$current; "
                     "  sleep 0.05; "
                     "done; "
                     "rm %s) > /dev/null 2>&1 &",
                     LOCK_PATH, SHM_PATH, LOCK_PATH);
            system(cmd);
        }

    } else {
        // Initial sync
        FILE *pipe = popen("ddcutil getvcp 10 --bus 0 --brief 2>/dev/null", "r");
        if (pipe) {
            char buf[128];
            if (fgets(buf, sizeof(buf), pipe)) {
                char *p = strstr(buf, "C ");
                if (p) {
                    val = atoi(p + 2);
                    write_val(val);
                } else { val = read_val(); }
            } else { val = read_val(); }
            pclose(pipe);
        } else {
            val = read_val();
        }
        printf("{\"text\":\"%s  %d%%\", \"percentage\":%d}\n", get_icon(val), val, val);
    }

    return 0;
}
