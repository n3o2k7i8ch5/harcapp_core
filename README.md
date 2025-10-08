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

### Quick Start

Import all sprawności books into the database:

```bash
make import_spraw_books
```

### Documentation

For detailed information about the sprawności module, including:
- Data structure and models
- Import process
- Querying examples
- Development guidelines

See **[`lib/sprawnosci/README.md`](lib/sprawnosci/README.md)**