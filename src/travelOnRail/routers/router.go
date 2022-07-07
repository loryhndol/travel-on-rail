package routers

import (
	"travelOnRail/controllers"
	"travelOnRail/controllers/admin"
	"travelOnRail/controllers/customer"

	"github.com/beego/beego/v2/server/web"
)

func init() {
	web.Router("/", &controllers.MainController{})
	web.AutoRouter(&admin.AdminController{})
	web.AutoRouter(&customer.CustomerController{})
	web.Router("/admin/ticket/all",&admin.TicketController{})
	web.Router("/customer/leftTicket", &customer.LeftTicketController{}, "get:Get")
	web.Router("/customer/leftTicket", &customer.LeftTicketController{}, "post:Post")
	web.Router("/customer/interchange", &customer.IcQueryController{})
	web.Router("/admin/train/index", &admin.TrainController{})
}
