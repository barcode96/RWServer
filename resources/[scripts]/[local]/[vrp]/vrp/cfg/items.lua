-- define items, see the Inventory API on github
local cfg = {}

local effectLuckyPotionUseUserIds = {}

local function drinkLuckyPotionEffect(player, idname, time, scale)
  local user_id = vRP.getUserId(player)
  local name = vRP.getItemName(idname)
  if user_id ~= nil then
    if effectLuckyPotionUseUserIds[user_id] and effectLuckyPotionUseUserIds[user_id] > os.time() - 10 then
      vRPclient.notify(player, {"~r~잠시 후에 이용가능합니다."})
      return
    end
    if vRP.tryGetInventoryItem(user_id, idname, 1, false) then
      vRPclient.playParticleEffect(player, {time, scale})
      effectLuckyPotionUseUserIds[user_id] = os.time() + time
      vRPclient.notify(player, {"~b~" .. name .. " 마심."})
      local seq = {
        {"mp_player_intdrink", "intro_bottle", 1},
        {"mp_player_intdrink", "loop_bottle", 1},
        {"mp_player_intdrink", "outro_bottle", 1}
      }
      vRPclient.playAnim(player, {true, seq, false})
      TriggerEvent("lucky_potion:drink", user_id, time)
      vRP.closeMenu(player)
    end
  end
end

-- see the manual to understand how to create parametric items
-- idname = {name or genfunc, description or genfunc, genfunc choices or nil, weight or genfunc}
-- a good practice is to create your own item pack file instead of adding items here
cfg.items = {
  ["festival_box_g"] = {"🎉 페스티벌 글자 상자", "[아이템 설명]<br>2020년 리얼월드 여름 페스티벌 글자 상자 입니다.<br>사용기간이 종료 되었습니다.", nil, 0.00},
  ["prison_ticket_1"] = {"🎫 노역 완료 1분 차감 티켓", "[아이템 설명]<br>10장씩 교환이 가능합니다.", nil, 0.01},
  ["castle_ticket_1"] = {"🎫 캐슬 입장권 1", "캐슬 1회 입장권", nil, 0.00},
  ["zombie_ticket_1"] = {"🎫 좀비존 입장권 (기본)", "[아이템 설명]<br>좀비존을 10분간 이용할 수 있는 입장권 입니다.<br><br>[주의사항]<br>좀비존을 벗어나면 시간과 관계없이 소비 됩니다.", nil, 0.00},
  ["benzoyl"] = {"🌿 벤조일", "코카인의 원료.", nil, 0.01}, -- no choices
  ["seeds"] = {"🌾 대마씨", "대마의 씨앗.", nil, 0.01}, -- no choices
  ["harness"] = {"🍁 LSD 원료", "LSD의 원료.", nil, 0.01}, -- no choices
  ["AK47"] = {"📦 AK47 부품", "", nil, 0.01}, -- no choices
  ["M4A1"] = {"📦 M4A1 부품", "", nil, 0.01}, -- no choices
  ["credit"] = {"💳 훔친 신용카드", "", nil, 0.01}, -- no choices
  --["driver"] = {"🎫 운전면허증", "운전면허증.", nil, 0}, -- no choices
  ["casino_token"] = {"🏮 (구)카지노 칩", "운영진에게 환전 받아주세요", nil, 0},
  ["real_chipc"] = {"🏮 (구)카지노 칩 [C]", "운영진에게 환전 받아주세요", nil, 0.01},
  ["real_chip_n"] = {"🏮 카지노 칩", "카지노 이용을 위한 칩", nil, 0.01},
  ["bank_money"] = {"💵 포장된 현금", "", nil, 0},
  ["fake_id"] = {"🎫 해킹 아이디", "", nil, 0}, -- no choices
  ["police_report"] = {"📝 경찰 보고서", "", nil, 0}, -- no choices
  ["ems_report"] = {"📝 의료국 보고서", "", nil, 0}, -- no choices
  ["cargo"] = {"📦 수송물품", "", nil, 0}, -- no choices
  ---------------------------------------
  ["thermal_charge"] = {"💣 고열 폭탄","",nil,0.0},
  ["laptop_h"] = {"💻 노트북","",nil,0.0},
  ["lockpick"] = {"🔐 락픽","",nil,0.0},
  ["id_card"] = {"💳 은행원 신분증","",nil,0.0},
  ["dia_box"] = {"[기타] 다이아몬드 상자","",nil,0.0},
  ["gold_bar"] = {"[기타] 금괴","",nil,0.0},
  ["button_bomb"] = {"🔘 폭발 버튼","",nil,0.0},
  ["gunpowder"] = {"💣 화약","",nil,0.0},
  ["BombRecipe"] = {"💣 고열 폭탄 제작법","",nil,0.0},
  ---------------------------------------
  ["ems_ticket_ev01"] = {"🎫 차량 자유 1시간 이용권", "[설명]<br>리얼월드 의료국 전용 아이템<br><br>[사용방법]<br>의료국에게 문의 하십시오.", nil, 0.01},
  ["ems_ticket_ev02"] = {"🎫 차량 자유 1일 이용권", "[설명]<br>리얼월드 의료국 전용 아이템<br><br>[사용방법]<br>의료국에게 문의 하십시오.", nil, 0.01},
  ["ems_ticket_ev03"] = {"🎫 차량 자유 7일 이용권", "[설명]<br>리얼월드 의료국 전용 아이템<br><br>[사용방법]<br>의료국에게 문의 하십시오.", nil, 0.01},
  ["ems_ticket_ev04"] = {"🎫 차량 자유 30일 이용권", "[설명]<br>리얼월드 의료국 전용 아이템<br><br>[사용방법]<br>의료국에게 문의 하십시오.", nil, 0.01},
  ---------------------------------------
  ["key_lspd"] = {"🔑 LSPD 경찰서 키", "", nil, 0.00},
  ["key_lspd_boss"] = {"🔑 LSPD 경찰서 룸 키", "", nil, 0.00},
  ["key_lsmc"] = {"🔑 병원 키", "", nil, 0.00},
  ["key_casino_main"] = {"🔑 카지노 키", "", nil, 0.00},
  ["key_prison_out"] = {"🔑 교도소 입구 키", "", nil, 0.00},
  ["key_prison_in"] = {"🔑 교도소 내부 키", "", nil, 0.00},
  ["key_chsr"] = {"🔑 신전입구 룸 키", "", nil, 0.00},
  ["key_sb_room"] = {"🔑 비밀요새 룸 키", "", nil, 0.00},
  ["key_sb_inside"] = {"🔑 비밀요새 통로 키", "", nil, 0.00},
  ["key_shh_house"] = {"🔑 흑사회 저택 키", "", nil, 0.00},
  ["key_mafia_house"] = {"🔑 백사회 저택 키", "", nil, 0.00},
  ["key_dok_house"] = {"🔑 독사회 저택 키", "", nil, 0.00},
  ["key_gm_house"] = {"🔑 에르지오 저택 키", "", nil, 0.00},
  ["key_newbie_main"] = {"🔑 뉴비지원센터 키", "", nil, 0.00},
  ["key_tow_main"] = {"🔑 리얼다이소 키", "", nil, 0.00},
  ["key_tow_room"] = {"🔑 리얼다이소 대표실 키", "", nil, 0.00},
  ["key_rc_main"] = {"🔑 리얼캐피탈 키", "", nil, 0.00},
  ["key_rc_room"] = {"🔑 리얼캐피탈 대표실 키", "", nil, 0.00},
  ["key_drug_factory"] = {"🔑 닭공장 키", "", nil, 0.00},
  ["key_helper_main"] = {"🔑 스태프 저택 키", "", nil, 0.00},
  ---------------------------------------
  ["Medical Weed"] = {"🍃 의료용 대마", "", nil, 0.05},
  ---------------------------------------
  ["picareta"] = {"⛏ 1회용 곡괭이", "", nil, 0.00},
  ---------------------------------------
  ["leather"] = {"🐊 동물 가죽", "", nil, 0.00},
  ["garrafa_vazia"] = {"🐄 우유박스", "", nil, 0.00},
  ---------------------------------------
  ["jtj1"] = {"🌊 깨끗한 물", "", nil, 0.25},
  ["jtj2"] = {"🍃 통마늘", "", nil, 0.25},
  ["jtj3"] = {"🎑 튼튼한 짚", "", nil, 0.25},
  ["jtj4"] = {"🏐 플라스틱", "", nil, 0.25},
  ["jtj5"] = {"💉 진통 약물", "", nil, 0.25},
  ["jtj6"] = {"🏺 응고된 가루", "", nil, 0.25},
  ["jtj8"] = {"💊 포장된 진통제", "", nil, 0.25},
  ["hd1"] = {"🍆 가지", "", nil, 0.25},
  ["hd2"] = {"🍋 레몬", "", nil, 0.25},
  ["hd3"] = {"🍎 사과", "", nil, 0.25},
  ["hd4"] = {"🍇 블루베리", "", nil, 0.25},
  ---------------------------------------
  ["ks1"] = {"🔧 가공된 유리", "", nil, 0.25},
  ["ks2"] = {"🔧 가공된 철근", "", nil, 0.25},
  ["sk1"] = {"🔧 수리용 뺀찌", "", nil, 0.25},
  ["sk2"] = {"🔧 수리도구함", "", nil, 0.25},
  ["fl1"] = {"🔧 라이트 헤더", "", nil, 0.25},
  ["fl2"] = {"🔧 라이트 손잡이", "", nil, 0.25},
  ---------------------------------------
  ["event_01"] = {"🈲 그", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_02"] = {"🈲 래", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_03"] = {"🈲 픽", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_04"] = {"🈲 카", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_05"] = {"🈲 드", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_06"] = {"🛐 헤", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_07"] = {"🛐 드", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_08"] = {"🛐 셋", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_09"] = {"🛐 키", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_10"] = {"🛐 보", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_11"] = {"🛐 드", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_12"] = {"🛐 기", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_13"] = {"🛐 프", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_14"] = {"🛐 티", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_15"] = {"🛐 콘", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_16"] = {"🛐 문", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_17"] = {"🛐 화", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_18"] = {"🛐 상", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_19"] = {"🛐 품", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_20"] = {"🛐 권", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_21"] = {"🈲 현", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_22"] = {"🈲 실", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_23"] = {"🈲 세", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ["event_24"] = {"🈲 계", "[아이템 설명]<br>여름 페스티벌 이벤트 글자 아이템이다.", nil, 0.01},
  ---------------------------------------
  ["event_trade_01"] = {"🈲 그래픽카드 추첨권", "[아이템 설명]<br>그래픽 카드 응모 or 꽝의 최종 형태 입니다.<br><br>[교환 아이템]<br>그,래,픽,카,드", nil, 0.01},
  ["event_trade_02"] = {"🛐 헤드셋 추첨권", "[아이템 설명]<br>헤드셋 응모 or 꽝의 최종 형태 입니다.<br><br>[교환 아이템]<br>헤,드,셋", nil, 0.01},
  ["event_trade_03"] = {"🛐 키보드 추첨권", "[아이템 설명]<br>키보드 및 마우스 응모 or 꽝의 최종 형태 입니다.<br><br>[교환 아이템]<br>키,보,드", nil, 0.01},
  ["event_trade_04"] = {"🛐 문화상품권 추첨권", "[아이템 설명]<br>문화상품권 5만원 응모 or 꽝의 최종 형태 입니다.<br><br>[교환 아이템]<br>문,화,상,품,권", nil, 0.01},
  ["event_trade_05"] = {"🛐 기프티콘 추첨권", "[아이템 설명]<br>치킨 기프티콘 응모 or 꽝의 최종 형태 입니다.<br><br>[교환 아이템]<br>기,프,티,콘", nil, 0.01},
  ["event_trade_06"] = {"🈲 리얼월드 굿즈 추첨권", "[아이템 설명]<br>리얼월드 굿즈 상품 응모 or 꽝의 최종 형태 입니다.<br><br>[교환 아이템]<br>현,실,세,계", nil, 0.01},
  ---------------------------------------
  ["ak47_1"] = {"📦 어썰트 라이플 MK2 조립상자", "", nil, 0.01},
  ["shotgun_1"] = {"📦 펌프 샷건 MK2 조립상자", "", nil, 0.01},
  ["smg_1"] = {"📦 SMG MK2 조립상자", "", nil, 0.01},
  ---------------------------------------
  ["bass_body"] = {"🐠 베스 몸통", "광장에서 판매할 수 있다.", nil, 0.01},
  ["bass_head"] = {"🐠 베스 머리", "광장에서 판매할 수 있다.", nil, 0.01},
  ["bass_j"] = {"🐠 베스 지느러미", "광장에서 판매할 수 있다.", nil, 0.01},
  ["catfish_body"] = {"🐠 메기 몸통", "광장에서 판매할 수 있다.", nil, 0.01},
  ["catfish_head"] = {"🐠 메기 머리", "광장에서 판매할 수 있다.", nil, 0.01},
  ["catfish_j"] = {"🐠 메기 지느러미", "광장에서 판매할 수 있다.", nil, 0.01},
  ["pisicademare_body"] = {"🐠 가오리 몸통", "광장에서 판매할 수 있다.", nil, 0.02},
  ["pisicademare_head"] = {"🐠 가오리 머리", "광장에서 판매할 수 있다.", nil, 0.02},
  ["pisicademare_j"] = {"🐠 가오리 꼬리", "광장에서 판매할 수 있다.", nil, 0.02},
  ["rechin_body"] = {"🐟 상어 몸통", "광장에서 판매할 수 있다.", nil, 0.02},
  ["rechin_head"] = {"🐟 상어 머리", "광장에서 판매할 수 있다.", nil, 0.02},
  ["rechin_j"] = {"🐟 상어 꼬리", "광장에서 판매할 수 있다.", nil, 0.02},
  ["pescarus_body"] = {"🍗 갈매기 몸통", "광장에서 판매할 수 있다.", nil, 0.01},
  ["pescarus_wing"] = {"🍗 갈매기 날개", "광장에서 판매할 수 있다.", nil, 0.01},
  ["pescarus_kori"] = {"🍗 갈매기 꼬리", "광장에서 판매할 수 있다.", nil, 0.01},
  ---------------------------------------
  ["mushroom_i"] = {"🍄 일반 버섯", "광장에서 판매할 수 있다.", nil, 0.00},
  ["mushroom_p"] = {"🍄 독버섯", "사용 업데이트 예정", nil, 0.00},
  ["mushroom_s"] = {"🍄 특별한 버섯", "사용 업데이트 예정", nil, 0.00},
  ---------------------------------------
  ["metaldetector"] = {"📡 금속 탐지기", "", nil, 2.5},
  ["explosivo_c4"] = {"💣 C4 폭발장치", "", nil, 5.5},
  ["normal_c4"] = {"💣 발전소 일반형 C4", "", nil, 0.5},
  ["mini_c4"] = {"💣 발전소 소형 C4", "", nil, 0.5},
  ["r_bs"] = {"💎 루비", "", nil, 0.5},
  ["s_bs"] = {"💎 사파이어", "", nil, 0.5},
  ["e_bs"] = {"💎 에메랄드", "", nil, 0.5},
  ["d_bs"] = {"💎 다이아몬드", "", nil, 0.5},
  ---------------------------------------
  ["zombie_ear"] = {"👂 좀비귀", "", nil, 0.00},
  ["zombie_arm"] = {"💪 좀비팔", "", nil, 0.00},
  ["zombie_head"] = {"💀 좀비머리", "", nil, 0.00},
  ["zombie_leg"] = {"🍤 좀비다리", "", nil, 0.00},
  ["zombie_medkit"] = {"🎃 좀비해독제", "", nil, 0.00},
  ---------------------------------------
  ["anti_market_item1"] = {"💀 GRANADE샷건", "", nil, 0.00},
  ["anti_market_item2"] = {"💀 컴뱃 MG 총알 10발", "", nil, 0.00},
  ["anti_market_item3"] = {"💀 피스톨.50 총알 10발", "", nil, 0.00},
  ["anti_market_item4"] = {"💀 GRANADE샷건 총알 10발", "", nil, 0.00},
  ["anti_market_item5"] = {"💀 어썰트샷건 총알 10발", "", nil, 0.00},
  ["anti_market_item6"] = {"💀 펌프샷건 총알 10발", "", nil, 0.00},
  ["anti_market_item7"] = {"💀 Hunter 칭호", "", nil, 0.00},
  ["anti_market_item8"] = {"💀 Undead 칭호", "", nil, 0.00},
  ["anti_market_item9"] = {"💀 Pandemic 칭호", "", nil, 0.00},
  ---------------------------------------
  ["special_goldmticket"] = {"🎫 오래된 금괴 미션 티켓", "[아이템 설명]<br>5개를 모으면 온전한 미션 사용권을 얻을 수 있습니다.", nil, 0},
  ["special_goldticket"] = {"🎫 금괴 미션 사용권", "[아이템 설명]<br>금괴 습격미션을 진행하기 위한 아이템 입니다.", nil, 0},
  ["goldwatch"] = {"🔶 금시계", "[아이템 설명]<br>금시계를 가지고 금괴 제련 장소로 이동 하십시요.", nil, 0},
  ["special_goldbar"] = {"🔶 융해된 금괴", "[아이템 설명]<br>금괴를 가지고 금괴 거래 장소로 이동 하십시요.", nil, 0},
  ["gold_mission_sp1"] = {"💰 찢어진 백지수표", "[아이템 설명]<br>찢어진 백지수표 50개를 모은 후 칭호를 교환하세요!", nil, 0},
  ["gold_mission_sp2"] = {"💰 오래된 백지수표", "[아이템 설명]<br>오래된 백지수표 80개를 모은 후 칭호를 교환하세요!", nil, 0},
  ["gold_mission_item1"] = {"💰 벼락부자 칭호", "[아이템 교환 조건]<br>찢어진 백지수표 50개", nil, 0},
  ["gold_mission_item2"] = {"💰 리치 & 리치 칭호", "[아이템 교환 조건]<br>오래된 백지수표 80개", nil, 0},
  ["gold_mission_item3"] = {"🎫 금괴 미션 사용권", "[아이템 교환 조건]<br>오래된 금괴 미션 티켓 5개", nil, 0},
  ["phone_1"] = {
    "📱 구형 휴대폰",
    "",
    function(args)
      return {
        ["*사용 하기"] = {
          function(player, choice)
            local user_id = vRP.getUserId(player)
            if user_id ~= nil then
              local data = vRP.getUserDataTable(user_id)
              if data then
                data.phoneitem = {}
                data.phoneitem.id = "phone_1"
              end
              vRPclient.notify(player, {"~g~착용 완료"})
              vRP.closeMenu(player)
            end
          end
        },
        ["사용 해제"] = {
          function(player, choice)
            local user_id = vRP.getUserId(player)
            if user_id ~= nil then
              local data = vRP.getUserDataTable(user_id)
              if data then
                data.phoneitem = {}
              end
              vRPclient.notify(player, {"~g~사용 해제 완료"})
              vRP.closeMenu(player)
            end
          end
        }
      }
    end,
    0.00
  },
  ["phone_2"] = {
    "📱 신형 휴대폰",
    "",
    function(args)
      return {
        ["*사용 하기"] = {
          function(player, choice)
            local user_id = vRP.getUserId(player)
            if user_id ~= nil then
              local data = vRP.getUserDataTable(user_id)
              if data then
                data.phoneitem = {}
                data.phoneitem.id = "phone_2"
              end
              vRPclient.notify(player, {"~g~착용 완료"})
              vRP.closeMenu(player)
            end
          end
        },
        ["사용 해제"] = {
          function(player, choice)
            local user_id = vRP.getUserId(player)
            if user_id ~= nil then
              local data = vRP.getUserDataTable(user_id)
              if data then
                data.phoneitem = {}
              end
              vRPclient.notify(player, {"~g~사용 해제 완료"})
              vRP.closeMenu(player)
            end
          end
        }
      }
    end,
    0.00
  },
  ["body_armor"] = {
    "🔷 방탄복",
    "총알의 피해를 최소화",
    function(args)
      return {
        ["*방탄복 착용"] = {
          function(player, choice)
            local user_id = vRP.getUserId(player)
            if user_id ~= nil then
              if vRP.tryGetInventoryItem(user_id, "body_armor", 1, true) then
                vRPclient.setArmour(player, {100, true})
                vRPclient.notify(player, {"~g~방탄복 착용 완료"})
                vRP.closeMenu(player)
              end
            end
          end
        }
      }
    end
  },
  ["lucky_potion1"] = {
    "🔮 행운의 물약",
    "행운을 가져다주는 물약<br>지속시간: 10초",
    function(args)
      local idname = args[1]
      return {
        ["*마시기"] = {
          function(player, choice)
            drinkLuckyPotionEffect(player, idname, 10, 1.5)
          end
        }
      }
    end
  },
  ["lucky_potion2"] = {
    "🔮 강화된 행운의 물약",
    "행운을 가져다주는 물약<br>지속시간: 20초",
    function(args)
      local idname = args[1]
      return {
        ["*마시기"] = {
          function(player, choice)
            drinkLuckyPotionEffect(player, idname, 20, 3.0)
          end
        }
      }
    end
  },
  ["lucky_potion3"] = {
    "🔮 강력한 행운의 물약",
    "행운을 가져다주는 물약<br>지속시간: 30초",
    function(args)
      local idname = args[1]
      return {
        ["*마시기"] = {
          function(player, choice)
            drinkLuckyPotionEffect(player, idname, 30, 5.0)
          end
        }
      }
    end
  }
}

-- load more items function
local function load_item_pack(name)
  local items = module("cfg/item/" .. name)
  if items then
    for k, v in pairs(items) do
      cfg.items[k] = v
    end
  else
    print("[vRP] item pack [" .. name .. "] not found")
  end
end

-- PACKS
load_item_pack("required")
load_item_pack("food")
load_item_pack("drugs")
load_item_pack("money")
load_item_pack("bonus")
load_item_pack("title")
load_item_pack("dataitems")
load_item_pack("sfoods")

return cfg
