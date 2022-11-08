-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = "test_1"
VERSION = "1.0.0"

-- sys库是标配
_G.sys = require("sys")

sys.taskInit(function()
	print("testTask000")
	x = 1
	while x == 1 do
		local wifiName = "CMCC"--设置wifi名称
		local wifiPasswd = "12345678."--设置wifi密码
		sys.wait(1000)
		wlan.init()--初始化wifi
		wlan.connect(wifiName, wifiPasswd)--连接wifi
		log.info("wlan", "wait for IP_READY")
		x = 2--跳出循环
	end
end)


sys.taskInit(function()
	sys.wait(5000)
	sys.wait(5000)--等待WiFi连接成功	
	print("开始mqtt")--开始执行mtqq初始化
	mqttc = mqtt.create(nil,"broker.emqx.io", 1883, nil, nil) --mtqq初始化
	mqttc:auth("mqttx_cc012198","username","password")--mqtt三元设置
	mqttc:keepalive(30) -- 默认值240s
    mqttc:autoreconn(true, 3000) -- 自动重连机制
	mqttc:connect()--连接
	log.info("mqtt_ok")

	sys.wait(5000)


	local topic = "mqtt/web"
	local data = "123"
	local qos = 0
    while true do
        sys.wait(5000)

		
            local pkgid = mqttc:publish(topic, data, qos) --发送

    end
end)

-- 用户代码已结束---------------------------------------------
-- 结尾总是这一句
sys.run()
-- sys.run()之后后面不要加任何语句!!!!!