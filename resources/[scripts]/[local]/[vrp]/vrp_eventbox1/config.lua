cfg = {}

cfg.global = {
	paytime = 600
}

cfg.giftbox = {
	msg_got = "~g~이벤트박스~w~ 개봉완료!",
	msg_got_n = "~r~이벤트박스가 부족합니다!",
	open_amount = 1
}

-- 종류, 확률(%), 코드, 이름, 개수(숫자:지정,배열:범위랜덤), 전체알림여부
cfg.rewards = {
	--{"item", 5.0, "eventitem_event1_ticket1", "🔖 문상교환권(천원권)", 1, true, 1000},
	{"item", 1.0, "eventitem_event1_ticket2", "🔖 문상교환권(오천원권)", 1, true, 5000},
	{"item", 0.5, "eventitem_event1_ticket3", "🎫 문상교환권(만원권)", 1, true, 10000},
	{"item", 0.1, "eventitem_event1_ticket4", "🎫 문상교환권(오만원권)", 1, true, 50000},
	{"item", 0.05, "eventitem_event1_ticket5", "🔥 문상교환권(십만원권)", 1, true, 100000},
	--{"item", 0.01, "eventitem_event1_ticket6", "🔥 문상교환권(오십만원권)", 1, true, 500000},
	{"money", 50, 100000, "💵 돈뭉치 10만원", 1, false},
	{"money", 30, 1000000, "💵 돈뭉치 100만원", 1, false},
	{"money", 5.0, 5000000, "💵 돈뭉치 500만원", 1, true},
	{"money", 1.0, 10000000, "💸 돈뭉치 1000만원", 1, true},
	{"money", 0.5, 50000000, "💸 돈뭉치 5000만원", 1, true},
	{"money", 0.1, 100000000, "💰 돈뭉치 1억원", 1, true},
	{"money", 0.05, 1000000000, "💰 돈뭉치 10억원", 1, true}
}

cfg.paycheck = {
	picture = "CHAR_BANK_BOL",
	title = "[이벤트 타임]",
	msg = "~w~일정시간이 지나 ~y~이벤트박스~w~를 받았습니다",
	amount = 1
}

cfg.open_giftbox = 1

function getConfig()
	return cfg
end
