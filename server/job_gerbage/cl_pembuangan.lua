local Gudang = {}
GUDANG_NAME = "[#INDOCOUNTRY] GUDANG A"

function bukaslur(asu)
	if asu.job == ESX.PlayerData.job.name or asu.job == 'vault' then
		  Gudang = asu
		  ESX.TriggerServerCallback("ic-base:asucokbuang", function(inventory, cuk)
				  if inventory then
					  TriggerEvent("ic-base:bukatempatsampah", inventory, cuk ,'steam:11000013c88cbea')
				 end
		 end,	asu)
	 end
end
  
Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(0)
		  local lokasi = GetEntityCoords(PlayerPedId())
		  for k,v in pairs(Config.Gudang) do
			  local dist = GetDistanceBetweenCoords(lokasi, v.lokasi, true)
			  if dist < 2 then
				DrawMarker(24, -447.78, -1700.93, 18.84, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.5, 255, 0, 0, 100, false, true, 2, true, false, false, false)
				DisplayHelpText('Tekan ~INPUT_CONTEXT~ buang barang')
				  if IsControlJustReleased(0, Keys['E']) then
					  bukaslur({job = k, asw = v.asw, buangselamannya = v.buangselamannya, janc0k = 'steam:11000013c88cbea', buangsekarang = v.gas})
				  end
			  end
		  end
	 end
end)
  

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

