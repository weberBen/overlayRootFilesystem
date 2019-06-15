# Protecting linux based system with overlay

Somme projects requires to disable writes to the storage device for embedded puposes where untimely shutdown happend or for safety purposes when an external cryptographic system is used to secure data, then it's fondamental to make sure that no userspace applications write data onto a storage device as background task.

The project enable user to protect it system from writing to the main storage device of computer without interfering with userspace applications. During boot process the root filesystem is mounted in a layers architecture with the root at the bottom and the computer RAM at the top, using [overlayFs](https://en.wikipedia.org/wiki/OverlayFS).
In other words, all the system storage device (commonly the hard drive) will be visible behind all the modification that will be saved into the RAM. As a result, no physical writes will be registered onto the system storage device.

In addition to a layer architechtures, some changes are made into the userspace to restrict its rights of modyfiyng the system, since some commands are handle at a low level and cannot be handle easily.


# Summary
- [Warning](#warning)
- [Overview](#overview)
- [Boot process](#boot)
- [Membre du groupe de recherche](#membres)  
- [Attribution des taches](#taches)
- [Modélisation d'un réseau biologique](#Modélisations)
  - [Présentation sommaire du sujet](#sujet)
  - [Une première modélisation (simplifiée)](#modélisation_simplifiee)
  - [Modélisation du poids des connexions](#Modélisation_2)
  - [Changement du pas de temps](#Modélisation_3)
  - [Modélisation d'une susbtance psychoactive](#Modélisation_psycho)
- [Modélisations mathématiques](#doc_ref) 


# Warning <a name="warning"/>

The system has been tested for a debian distribution (above 2.6). It contains graphical compenents that might not work for other linux architecture.

# Overview <a name="overview"/>

The system acts on three process :

  - During the boot, user can choose to mount *overlay* on the root filesystem. Then all files onto the main filesystem will be visible and all modifications will be saved into the RAM. A kernel module is also loaded to save the user answer
  - At startup (when the filesystem has been remounted as read-write), content of the kernel module is read and add as an environment variable in `/etc/environment`. Then the module is unloaded
  - At login (in graphical mode or ina login shell), a message is displayed
  
# Boot process <a name="boot"/>

<img src="ressources/images/boot.png" width="100%"  align="middle">
