// Main menu options
options[0, 0] = "Start";
options[0, 1] = "Settings";
options[0, 2] = "Quit";

// Settings submenu
options[1, 0] = "Something";
options[1, 1] = "Back";

// Menu variables
pos = 0;
menu_depth = 0;
op_length = array_length(options[menu_depth]);

// Button options
button_width = 96;
button_height = 24;
button_space = 34;