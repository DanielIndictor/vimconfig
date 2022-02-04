This repository should be moved to your `.vim` directory.
Crucially, it provides clangd errors (telling you which line has coding errors) as well as auto-formatting of C/C++ files (both on save and on operator `=`.

To set it up, you'll need to do:
```bash
git clone git@github.com:DanielIndictor/vimconfig.git
cd vimconfig
git submodule init
git submodule update
```
Next, open vim (which should give some error messages possibly) and run the command
```
:PluginInstall
```
This'll take a bit.

Close vim, and, from `vimconfig/`, run the following:
```bash
cd bundle/YouCompleteMe
./install.py --clangd-completer
```

This'll require you have Python and `clangd` installed.

And that's it! Open a c++ file and check if it works!
