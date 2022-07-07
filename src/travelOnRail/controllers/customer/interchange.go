package customer

import (
	"fmt"
	"travelOnRail/controllers"

	"github.com/beego/beego/v2/client/orm"
)

type IcQueryController struct {
	controllers.BaseController
}

func (page *IcQueryController) Get() {
	page.O = orm.NewOrm()

	// 车站名称
	var stations []string
	num, err := page.O.Raw("SELECT station_name from tb_office").QueryRows(&stations)
	if err != nil {
		fmt.Println(err.Error())
	} else {
		page.Data["num"] = num
		page.Data["stations"] = stations
	}

	page.TplName = "customer/interchange.html"
}
