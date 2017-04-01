# Intention

This layout is specifically designed to ensure building Kicad from a specific commit in order to make all team members run exactly the same version of Kicad, thus allowing all members exchange their projects coherently.

# Usage

In order to download Kicad source code: 

```
./prepare.sh  # for the first time
```

In order to install (and update), run: 
```
./build-kicad.sh 
./create-deb-pkg.sh # generate a debian package
```
