import json
from pathlib import Path

BASE = Path.home() / ".config/Code/User/settings.json"
COLORS = Path.home() / ".config/Code/User/colors-vscode.json"

base = json.loads(BASE.read_text())
colors = json.loads(COLORS.read_text())

for key, value in colors.items():
    if key in base and isinstance(base[key], dict) and isinstance(value, dict):
        base[key].update(value)  # deep merge one level
    else:
        base[key] = value

BASE.write_text(json.dumps(base, indent=4))
