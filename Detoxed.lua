--------------------
-- For Detoxed <3 --
--------------------
local Detoxed = LibStub("AceAddon-3.0"):NewAddon("Detoxed", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")

local InCombatLockdown = _G["InCombatLockdown"]
local PlaySoundFile = _G["PlaySoundFile"]
local random = math.random

local pictures = {
	[[Interface\AddOns\Detoxed\Media\cat.tga]],
	[[Interface\AddOns\Detoxed\Media\cat2.tga]],
	[[Interface\AddOns\Detoxed\Media\cat3.tga]],
}

local sounds = {
	[[Interface\AddOns\Detoxed\Media\CatMeow2.ogg]],
	[[Interface\AddOns\Detoxed\Media\KittenMeow.ogg]],
}

function Detoxed:ShowFrame()
	PlaySoundFile(sounds[random(1, #sounds)])
	self.frame.bg:SetTexture(pictures[random(1, #pictures)])
	self.frame:Show()
end

function Detoxed:OnDisable()
	self:CancelAllTimers()
end

function Detoxed:OnEnable()
	self:ScheduleTimer(function()
		self:ShowFrame()
		self:ScheduleTimer(function() self.frame:Hide() end, random(1, 10))
		self.displayTimer = self:ScheduleRepeatingTimer(function()
			local toShow = random(1, 100)
			if toShow > 50 and not InCombatLockdown() then
				self:ShowFrame()
				self:ScheduleTimer(function() self.frame:Hide() end, random(1, 10))
			end
		end, 120)
	end, random(10, 30))
end

function Detoxed:OnInitialize()
	-- create the frame
	self.frame = CreateFrame("Frame", "DetoxedFrame", UIParent)
	self.frame:SetResizable(false)
	self.frame:SetClampedToScreen(true)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("CENTER")
	self.frame:SetSize(512, 512)
	self.frame.bg = self.frame:CreateTexture(nil, "BACKGROUND")
	self.frame.bg:SetPoint("CENTER")
	self.frame.bg:SetSize(512, 512)
	self.frame:Hide()
end