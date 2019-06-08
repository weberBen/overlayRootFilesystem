# Protecting linux based system with overlay

# Summary
- [Abstract](#abstract)
- [Comptes rendus](#compte_rendu)
- [Planning des semaines](#agenda)
- [Membre du groupe de recherche](#membres)  
- [Attribution des taches](#taches)
- [Modélisation d'un réseau biologique](#Modélisations)
  - [Présentation sommaire du sujet](#sujet)
  - [Une première modélisation (simplifiée)](#modélisation_simplifiee)
  - [Modélisation du poids des connexions](#Modélisation_2)
  - [Changement du pas de temps](#Modélisation_3)
  - [Modélisation d'une susbtance psychoactive](#Modélisation_psycho)
- [Modélisations mathématiques](#doc_ref) 


# Abstract <a name="abstract"/>

Somme projects requires to disable writes to the storage device for embedded puposes where untimely shutdown happend or for safety purposes when an external cryptographic system is used to secure data, then it's fondamental to make sure that no userspace applications write data onto a storage device as background task.

The project enable user to protect it system from writing to the main storage device of computer without interfering with userspace applications. During boot process the root filesystem is mounted in a layers architecture with the root at the bottom and the computer RAM at the top, using [overlayFs](https://wiki.archlinux.org/index.php/Overlay_filesystem).
In other words, all the system storage device (commonly the hard drive) will be visible behind all the modification that will be saved into the RAM. As a result, no physical writes will be registered onto the system storage device.

In addition to a layer architechtures, some changes are made into the userspace to restrict its rights of modyfiyng the system, since some commands are handle at a low level and cannot be handle easily.
