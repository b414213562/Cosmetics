import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

import "CubePlugins.Cosmetics.Data.cosmetics_head"

GetItemQuickslot = Turbine.UI.Lotro.Quickslot();
GetItemQuickslot:SetSize(1,1);
GetItemQuickslot:SetVisible(false);
function SetItemShortcut(link)
    GetItemQuickslot:SetShortcut(Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Item, link));
end
function GetItem(link)
    if (pcall(SetItemShortcut, link)) then
        return GetItemQuickslot:GetShortcut():GetItem();
    end
    return nil;
end

function DrawCosmeticWin()
    CosmeticsWin = Turbine.UI.Lotro.Window();
    --CosmeticsWin:SetBackColor(Turbine.UI.Color.Blue);
    CosmeticsWin:SetVisible(true);
    CosmeticsWin:SetResizable(true);
    CosmeticsWin:SetText("Cosmetics");
    CosmeticsWin:SetPosition(600,100);
    CosmeticsWin:SetSize(600, 800);
    CosmeticsWin:SetBackColor(Turbine.UI.Color.DarkGreen);
    CosmeticsWin:SetBackColorBlendMode(Turbine.UI.BlendMode.Color);

    CosmeticsWin.cosmeticListBox = Turbine.UI.ListBox();
    CosmeticsWin.cosmeticListBox:SetParent(CosmeticsWin);
    CosmeticsWin.cosmeticListBox:SetSize(550, 750);
    CosmeticsWin.cosmeticListBox:SetPosition(25, 40);
    CosmeticsWin.cosmeticListBox:SetBackColor(Turbine.UI.Color.Green);
    CosmeticsWin.cosmeticListBox:SetBackColorBlendMode(Turbine.UI.BlendMode.Color);
    CosmeticsWin.cosmeticListBox:SetOrientation(Turbine.UI.Orientation.Horizontal);
    CosmeticsWin.cosmeticListBox:SetMaxColumns(15);

    CosmeticsWin.cosmeticListBoxScrollBar = Turbine.UI.Lotro.ScrollBar();
    CosmeticsWin.cosmeticListBoxScrollBar:SetParent(CosmeticsWin);
    CosmeticsWin.cosmeticListBoxScrollBar:SetSize(8, CosmeticsWin.cosmeticListBox:GetHeight());
    CosmeticsWin.cosmeticListBoxScrollBar:SetPosition(CosmeticsWin.cosmeticListBox:GetLeft() + CosmeticsWin.cosmeticListBox:GetWidth() + 2, CosmeticsWin.cosmeticListBox:GetTop());
    CosmeticsWin.cosmeticListBoxScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    CosmeticsWin.cosmeticListBoxScrollBar:SetZOrder(1);
    CosmeticsWin.cosmeticListBoxScrollBar:SetVisible(false);

    CosmeticsWin.cosmeticListBox:SetVerticalScrollBar(CosmeticsWin.cosmeticListBoxScrollBar);

    if (Data.COSMETIC_HEAD == nil) then
        Turbine.Shell.WriteLine("ERROR, COSMETIC_HEAD == nil");
        return;
    end
    -- Add some items to look at:
    for k,v in pairs(Data.COSMETIC_HEAD) do
        local item = GetItem(v.LINK);
        if (item ~= nil) then
            local itemInfoControl = Turbine.UI.Lotro.ItemInfoControl();
            itemInfoControl:SetSize(36, 36);
            itemInfoControl:SetPosition(0, 0);
            itemInfoControl:SetItemInfo(item:GetItemInfo());
            itemInfoControl:SetQuantity(#v.ITEM_IDS);
            CosmeticsWin.cosmeticListBox:AddItem(itemInfoControl);
        end
    end


end

DrawCosmeticWin();