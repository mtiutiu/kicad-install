# Intention

This layout is specifically designed to ensure building Kicad from a specific commit in order to make all team members run exactly the same version of Kicad, thus allowing all members exchange their projects coherently.

# Usage


### Installing Kicad

```
./prepare.sh  # for the first time
```

In order to install (and update), run: 
```
./build-kicad.sh 
./create-deb-pkg.sh # generate a debian package
# install your .deb package by dpkg: 
# dpkg -i kicad/build/release/kicad-...deb
```

### Installing default Kicad libraries 

```
./install-kicad-library.sh
```
