
# scan-libs
Simple Gmod libs to scan directory of the location you want and return a table containing folder / file

# How to use!

First you need to add the libs in the autorun (addons/youraddons/lua/autorun/nnt-filescan.lua)
Then you can Simply do the following
```lua
local Scan = NNT.Libs.FileScan:Init()
Scan:SetPath("*", "GAME")
Scan:SetAllowedFileType({
    ["lua"] = true
})
Scan:SetAllowedFolders({
    ["addons"] = true,
    ["lua"] = true
})
local result = Scan:Exec() -- will return a table with the folder / file
PrintTable(result["lua"]["autorun"]) -- will return all file in lua/autorun
```
### Simple Explication
- NNT.Libs.FileScan:Init() | will return a scan object  example  `local scan = NNT.Libs.FileScan:Init()`
- Scan:SetPath("*", "GAME") | will allow you to set the path, "GAME" => [list you can use here!](https://wiki.facepunch.com/gmod/File_Search_Paths)
- Scan:SetAllowedFileType(FileTable) | arguments is the table containing all file type you want to find
- Scan:SetAllowedFolders(FolderTable) | arguments is the table containing all the root folder you want to find recursively find in.
- Scan:Exec() | Execute the scan and return the result (table)
