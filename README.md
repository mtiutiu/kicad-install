# Intention

This layout is specifically designed to ensure building Kicad from a specific commit in order to make all team members run exactly the same version of Kicad, thus allowing all members exchange their projects coherently.

# Usage

1. Install Kicad 
2. Install libraries, footprints and 3D shapes 
3. Update paths

## 1. Installing Kicad

```
./prepare.sh  # for the first time
```

In order to install (and update), run:
```
./build-kicad.sh
./create-deb-pkg.sh # generate a debian package
```

install your .deb package by `dpkg`:
```
# dpkg -i kicad/build/release/kicad-...deb
```

## 2. Installing Libraries, Footprints and 3D Shapes

### Default Kicad Libraries

```
./install-kicad-library.sh
./install-kicad-packages3d.sh
```

### Aktos Libraries

```
./install-aktos-library.sh
```

## 3. Updating Paths
After copying appropriate files to appropriate folders, update `fp_lib_table`
and the kicad template:

```
./update-fplib-table.sh
./update-kicad-template.sh
```
