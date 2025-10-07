# harcapp_core

A Flutter package for HarcApp related applications.  
See:
- https://github.com/n3o2k7i8ch5/harcapp
- https://github.com/n3o2k7i8ch5/harcapp_web

## Setup for development
1. ```bash
   make install
   ```
2. Add to shell's config file (e.g. `~/.bashrc` or `~/.zshrc`):
   ```bash
   export PATH="$PATH":"$HOME/.pub-cache/bin"
   ```

## Working with Sprawności Database

### Count sprawności in the database
```bash
make count_spraws
```

Or directly:
```bash
dart run tool/count_spraws.dart [isarDir?]
```

This will display:
- Total counts of books, groups, families, spraws, and tasks
- Breakdown of spraws per book