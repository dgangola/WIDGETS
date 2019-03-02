# Betaflight Widget for Horus/OpenTX Radios
Requires Betaflight scripts v1.10 to be installed.  
  
  
This is a widget adaptation of the v1.10  Betaflight telemetry scripts.  Same content as the original, just accessible as a widget, on the Horus series radios, running a modified OpenTX.
### THE FILES
There are four files in the  WIDGETS/BetaFlit folder:

* **main.lua**  
The file that is initially loaded, and defines the widget.  Probably the only file that should be in this directory.
* **events.lua**  
A copy of the SCRIPTS/BF/events.lua file, with a few added definitions.  This should be backward compatible. Placed here to avoid corrupting the original Betaflight package.
* **radios.lua**  
A copy of the SCRIPTS/BF/radios.lua file, with the addition of the X10-simu radio type for development.  Not needed for use in physical radios.  Placed here to avoid corrupting the original Betaflight package.
* **ui.lua**  
A copy of the SCRIPTS/BF/ui.lua file, with modifications to run as a widget.  Utimately, I would like this to be able to be backward compatible with the stand-alone script.  It's not there yet.  Placed here to avoid corrupting the original Betaflight package.

These scripts contain references to the widget's directory, so they must be placed in WIDGETS/BetaFlit to work without modification.  Changing the directory name will require the references to be changed as well.
