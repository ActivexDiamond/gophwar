local version = {}

------------------------------ Locals ------------------------------

--The chronological ordering of branches, used for comparing versions to check which is newer.
local branches = {
	alpha = 1,
	beta = 2,
	prerelease = 3,
	none = 10,
}

------------------------------ Constants ------------------------------
version.VERSION_FILE_PATH = "src/cat-paw/version"

------------------------------ Internals ------------------------------
function version._readVersionFromFile()
	local f = assert(io.open(version.VERSION_FILE_PATH, 'r'))
	version.VERSION_STRING = f:read("*all")
	f:close()
end

------------------------------ Metamethods ------------------------------
function version.__tostring()
	return version.VERSION_STRING
end

------------------------------ Quick Test ------------------------------

--[[
print(version.getVersionString())
version.HOTFIX = 0
print(version.getVersionString())
version.HOTFIX = 42
print(version.getVersionString())

version.HOTFIX = 1.2
print(version.getVersionString())	--Should fail due to invalid HOTFIX.
--]]

------------------------------ Finalize & Returns ------------------------------
setmetatable(version, version)

--The version is expected to never change at runtime, so only computing this once on import should be fine.
version._readVersionFromFile()

return version
