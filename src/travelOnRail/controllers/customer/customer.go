package customer

import (
	"travelOnRail/controllers"
)

type CustomerController struct {
	controllers.BaseController
}

func (customer *CustomerController) Index() {
	customer.TplName = "customer/index.html"
}

func (customer *CustomerController) Logout() {
	customer.DestroySession()
	customer.History("Logout", "customer/login.html")
}
