NNT = NNT or {}
NNT.Libs = NNT.Libs or {}
NNT.Libs.FileScan = {
    Init = function(self)
        self.BlacklistedFile = {}
        self.BlacklistedFolder = {}
        return self
    end,
    SetPath = function(self, dir, path)
        self.Dir = dir
        self.Path = path
    end,
    GetPath = function(self) return self.Dir, self.Path end,
    SetAllowedFileType = function(self,filetb)
        self.AllowedFileType = filetb
    end,
    SetAllowedFolders = function(self,filetb)
        self.AllowedFolders = filetb
    end,
    AddFile = function(self, cleandir, entry, content)
        local filedir = string.Split(cleandir, "/")
        table.remove(filedir)
        local tb = table.Reverse(filedir)

        local res = {
            [entry] = content
        }

        for i = 1, #tb do
            res = {
                [tb[i]] = res
            }
        end

        table.Merge(self.Result, res)
    end,
    DoRecursive = function(self, dir, path)
        local cleandir = string.Replace(dir, "*", "")
        local files, folders = file.Find(dir, path,"nameasc")
        if files then
            for i = 1, #files do
                if self.AllowedFileType[string.GetExtensionFromFilename(files[i])] then
                    self:AddFile(cleandir, files[i], cleandir .. files[i])
                end
            end
        end

        if folders then
            for i = 1, #folders do
                if self.AllowedFolders[string.Split(cleandir .. folders[i], "/")[1]] then
                    self:DoRecursive(cleandir .. folders[i] .. "/*", path)
                end
            end
        end
    end,
    Exec = function(self)
        if not self.Path then return {} end
        self.Result = {}
        self:DoRecursive(self.Dir, self.Path)
        return self.Result
    end
}

NNT.Libs.FileScan.__index = NNT.Libs.FileScan