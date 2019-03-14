local PanelUI = class("PanelUI", cc.Node)

function PanelUI:getChild(...)
	local args = {...}
	parent = self
	if parent then
		for i, v in pairs(args) do
			parent = parent:getChildByName(v)
		end
		return parent
	end

end
return PanelUI