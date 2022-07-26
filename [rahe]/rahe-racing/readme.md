How to install RAHE Racing?

1. Run the SQL queries provided in rahe-racing/db.sql

2. Depending on your framework:
   * ESX - Move client.lua & server.lua from 'rahe-racing/api/esx' to 'rahe-racing/api/'.
   * QB - Move client.lua & server.lua from 'rahe-racing/api/qb' to 'rahe-racing/api/'.
   * Standalone - Move client.lua & server.lua from 'rahe-racing/api/standalone' to 'rahe-racing/api/'. By default, the identifier is set to Steam.

3. Make sure you are running Oxmysql (VERY IMPORTANT! Make sure your Oxmysql version is at least 2.0.0. Older versions WILL NOT work)   
4. Start the script & enjoy! By default the tablet opens using the '/racing' command.

5.If you wish to have some initial tracks, run rahe-racing/tracks.sql.
If you encounter problems during importing tracks, set max_allowed_packet=100M in your MySQL configuration (my.ini).

Join our Discord for support and future updates / patch notes: https://discord.gg/Ckm4tVbmRE