Hi, thank you for buying my script, I'm very grateful!

If you need help contact me on discord: okok#3488
Discord server: https://discord.gg/okok

You can find everything you need to set okokCrafting up in the config file.
You should add the item images inside the icons folder "okokCrafting/web/icons".
The images name should be EXACTLY the same that is in your server's database.
The images format MUST BE ".png", otherwise they won't show up.

[IMPORTANT]
The 'tableID' field on the config file is used to create the craft buttons, so make sure you ALWAYS set a different ID for each table.

[XP SYSTEM]
To use xp add this column to your database and set it up on the config.lua:
ALTER TABLE players ADD COLUMN xp INT(255) NOT NULL default 0;