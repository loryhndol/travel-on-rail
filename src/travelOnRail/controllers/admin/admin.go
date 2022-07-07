package admin

import (
	"travelOnRail/controllers"
)

type AdminController struct {
	controllers.BaseController
}

func (admin *AdminController) Logout() {
	admin.DestroySession()
	admin.History("Logout", "admin/login.html")
}

func (admin *AdminController) Index() {
	admin.TplName = "admin/index.html"
}
