# CoP (Calculate of Pointers)
The program calculates pointers for NES and GameBoy(GamaBoy Color) games. 

## How to work
After launching the program you will see main window of it. There are follow components:
- **"Platform" list area** - here you can select a platform you need
- **"Offsets" text area** is used for entering original offsets. Button at right of the text area is used for export list of offsets from text file
- **"Pointers" text area** is text area where you will see calculated pointers according the offsets. Button at right of the text area is used for import calculated pointers in text file
- **"Calculate** button runs the calculation
- **"Settings" or "Size" areas** are used for set up calculation for the platform you selected
- **Progress bar** below the areas shows progress of calculation
- **"About" button**(button with interrogation mark) shows message about the program and the developer

You must do follow steps:
1. Select a platform
2. Enter are offsets
3. Select size of pointers (in case GB or GBC) or enter settings (in case NES)
4. Press "Calculate" button
5. Take calculated pointers

Note that pointers' settings of NES games you can take from file nes.cop. Structure of this file is:
> Name\_of\_game/bank/composed

## Version history
**Version 1.3**

Added:
- Capability of adding the data for the calculation NES-pointers into 'NES.cop' file.

**Version 1.2**

Added:
- Capability of loading the pointers from the file and saving the calculated pointers into the file.

**Version 1.1**

Added:
- Support of NES-pointers for some games.

**Version 1.0**

- First version of the program. It supports two-byte and three-byte pointers of GameBoy and GameBoy Color.
