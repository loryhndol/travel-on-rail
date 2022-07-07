package controllers

import (
	"fmt"
	"strings"
	"travelOnRail/models"
	"travelOnRail/util"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/server/web"
)

type BaseController struct {
	web.Controller
	O          orm.Ormer
	ActionName string
}

func (p *BaseController) History(msg string, url string) {
	if url == "" {
		p.Ctx.WriteString("<script>alert('" + msg + "');window.history.go(-1);</script>")
		p.StopRun()
	} else {
		p.Redirect(url, 302)
	}
}

func (p *BaseController) getClientIp() string {
	s := strings.Split(p.Ctx.Request.RemoteAddr, ":")
	return s[0]
}

type MainController struct {
	BaseController
}

func (main *MainController) Post() {
	username := main.GetString("u")
	password := main.GetString("p")

	main.O = orm.NewOrm()

	user := &models.UserAccount{UserName: username, Passwd: password}
	err := main.O.Read(user, "user_name")

	if err != nil {
		fmt.Println(err)
	}
	if user.Passwd == "" {
		main.History("Account Not Found", "")
	}

	if util.Md5(password) != strings.Trim(user.Passwd, " ") {
		main.History("Wrong Password", "")
	}

	if username == "admin" {
		main.History("Login Successfully", "admin/index.html")
	} else {
		main.History("Login Successfully", "customer/index.html")
	}
	main.SetSession("user", user)
}

func (main *MainController) Get() {
	main.Data["Website"] = "travel-on-rail.vip"
	main.Data["Email"] = "foobar@gmail.com"
	main.TplName = "index.html"
}
