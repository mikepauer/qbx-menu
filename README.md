# qbx-menu
Updated context menu for QB-Core or QBX-Core

This is a fork of https://github.com/jimathy/jixel-menu which is a fork of https://github.com/Renewed-Scripts/qb-menu which is a fork of https://github.com/qbcore-framework/qb-menu which is a fork of NH Context by NeroHiro

This version adds supporting both ox-inventory and qb-inventory (or derevitives) for menu images
It also adds 2 new menu parameters:

enableSearch = true  # This will turn on the menu search bar which by default is disabled now
image = 'url' # This allows for popup context images to be displayed

Sample Config:
local menu = {
  {
    isDisabled = true,
    enableSearch = true,
    header = "<center><img src=https://static.wikia.nocookie.net/gtawiki/images/d/df/Dynasty8-GTAV-Logo.png width=250.0rem>",
    txt = "",
    isMenuHeader = true
  },
  {
    header = 'Apt #8, Alta St',
    image = 'https://imgur.com/a/3RMGSOE',
    txt = "Buy for $2500",
  }
}
exports['qbx-menu']:OpenMenu(menu)

![context settings preview](https://i.imgur.com/YTi6AxC.jpg)
