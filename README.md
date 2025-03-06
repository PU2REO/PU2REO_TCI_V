# PU2REO_TCI_V
Icom's CI-V Component - Object Pascal (Delphi) implementation.

Icom's CI-V protocol, standing for "Communication Interface - V," is a proprietary system enabling computer-based control of Icom transceivers and receivers. Introduced in the mid-1980s, it allows for the automation of various radio functions, such as frequency tuning and mode selection, through a computer interface. 

# Technical Overview:

The CI-V protocol operates on a simple, bidirectional, single-wire TTL (Transistor-Transistor Logic) signaling system. This system consists of a data line (DATA) and a ground reference (GND), with the DATA line held high when idle. Any device can initiate communication by pulling the line low and sending the Icom attention command (FEFE). This setup allows multiple devices to share the same communication line, provided each has a unique hexadecimal address. 
KA1MDA.ORG

# Compatible Devices:

Most Icom radios manufactured since the mid-1980s are equipped with CI-V ports, facilitating computer control. Notable models include:

  * IC-7300
  * IC-705
  * IC-9700
  * IC-7100
  * IC-7610
  * IC-7000
  * IC-7800
  * IC-7100
  * IC-7200
  * IC-7700
  * IC-7810
  * IC-718
  * IC-756
  * IC-746
  * IC-706
  * IC-703

Additionally, receivers like the R-71A and R-7000 also support CI-V, allowing for synchronized operation with transceivers. 

# Interfaces and Accessories:

To connect CI-V compatible radios to computers, interfaces like the CT-17 are commonly used. These devices convert RS-232 signals from the computer to TTL levels suitable for the CI-V port. While Icom offers its own interfaces, many amateur radio enthusiasts opt for DIY solutions or third-party interfaces to reduce costs. For instance, simple circuits using the MAX-232 IC can be constructed to serve this purpose. 

Commercially available USB-to-CI-V cables, such as those from Valley Enterprises, provide plug-and-play solutions for modern computers without traditional serial ports. 

# Additional Tools
  * [NRComm Lib (Necessary. Trial version will do it fine!)](https://www.deepsoftware.com/nrcomm/)
  * [Raize CodeSite (Unnecessary. Using it just for debug)](https://raize.com/codesite/)