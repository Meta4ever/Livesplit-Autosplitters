state("ys1plus") //Chronicles+ on Steam
{
    byte jenoHealth : 0x0221810, 0x180;
    byte nygtilHealth : 0x0221818, 0x180;
    byte vagulHealth : 0x0221848, 0x180;
    byte pictiHealth : 0x0221834, 0x180;
    byte khonHealth : 0x0221814, 0x180;
    byte yogomuHealth : 0x022184C, 0x180;
    byte factHealth : 0x022180C, 0x180;
    byte titleExit : 0x0223FD4;
    byte bookFact : 0x0137A98;
    byte endText : 0x022D520;
}

state("ys1c") //Chronicles JP version
{
    //For some reason all of these return 0 even though they are the right addresses
    byte jenoHealth : "ys1c.bin", 0x0153668, 0x180;
    byte nygtilHealth : "ys1c.bin", 0x0153658, 0x180;
    byte vagulHealth : "ys1c.bin", 0x0153648, 0x180;
    byte pictiHealth : "ys1c.bin", 0x015364C, 0x180;
    byte khonHealth : "ys1c.bin", 0x015364C, 0x180;
    byte yogomuHealth : "ys1c.bin", 0x0153644, 0x180;
    byte factHealth : "ys1c.bin", 0x0153644, 0x180;
    byte titleExit : "ys1c.bin", 0x01CE588;
    byte bookFact : "ys1c.bin", 0x0122A98;
    byte endText : "ys1c.bin", 0x021FD0C;
    
    //Just used for testing
    byte adolHealth : "ys1c.bin", 0x1221B4;
}

startup
{
    vars.lastSplit = false;
    vars.splitCount = 0;
}

init
{
    int moduleSize = modules.First().ModuleMemorySize;

    if (moduleSize == 2641920)
    {
        version = "ys1plus";
    }
    if (moduleSize == 303104)
    {
        version = "ys1c";
    }
}

update
{

if (vars.splitCount == 0)
{
    vars.startTimer = false;
}

//Final Split Activation
    if (vars.splitCount == 8 && current.bookFact == 1 && current.endText == 1)
    {
	    vars.lastSplit = true;
    }
}

start
{

//Start condition
    if (vars.splitCount == 0 && current.titleExit == 0 && old.titleExit == 1)
    {
        vars.splitCount = 1;
        return true;
    }
}

split
{
    //Boss Kill Splits
    if (vars.splitCount == 1 && current.jenoHealth <= 0 && old.jenoHealth > 0)
    {
        vars.splitCount += 1;
	    return true;
    }
    if (vars.splitCount == 2 && current.nygtilHealth <= 0 && old.nygtilHealth > 0)
    {
        vars.splitCount += 1;
	    return true;
    }
    if (vars.splitCount == 3 && current.vagulHealth <= 0 && old.vagulHealth > 0)
    {
        vars.splitCount += 1;
	    return true;
    }
    if (vars.splitCount == 4 && current.pictiHealth <= 0 && old.pictiHealth > 0)
    {
        vars.splitCount += 1;
	    return true;
    }
    if (vars.splitCount == 5 && current.khonHealth <= 0 && old.khonHealth > 0)
    {
        vars.splitCount += 1;
	    return true;
    }
    if (vars.splitCount == 6 && current.yogomuHealth <= 0 && old.yogomuHealth > 0)
    {
        vars.splitCount += 1;
	    return true;
    }
    if (vars.splitCount == 7 && current.factHealth <= 0 && old.factHealth > 0)
    {
        vars.splitCount += 1;
	    return true;
    }

    //Final Split
    if (vars.lastSplit)
    {
	    if (current.endText == 0)
	    {
            vars.lastSplit = false;
            vars.splitCount = 0;
	        return true;
	    }
    }
}
