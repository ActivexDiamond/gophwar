local version = {}

--The chronological ordering of branches, used for comparing versions to check which is newer.
local branches = {
	alpha = 1,
	beta = 2,
	prerelease = 3,
	none = 10,
}
	
version.BRANCH = "dev"
version.STABILITY_IDENTIFIER = 1
version.MAJOR = 1
version.MINOR = 0
version.HOTFIX = 0

function version.__tostring()
	if version.HOTFIX > 0 then
		return string.format("%s-%i.%i.%i_%i", version.BRANCH, version.STABILITY_IDENTIFIER,
				version.MAJOR, version.MINOR, version.HOTFIX)
	end
	return string.format("%s-%i.%i.%i", version.BRANCH, version.STABILITY_IDENTIFIER,
			version.MAJOR, version.MINOR)
end

--print(version.getVersionString())
--version.HOTFIX = 0
--print(version.getVersionString())
--version.HOTFIX = 42
--print(version.getVersionString())
--
--version.HOTFIX = 1.2
--print(version.getVersionString())	--Should fail

setmetatable(version, version)
return version