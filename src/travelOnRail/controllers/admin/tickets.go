package admin

import (
	"fmt"
	"travelOnRail/controllers"
	"travelOnRail/models"

	"github.com/beego/beego/v2/client/orm"
)

type TicketController struct {
	controllers.BaseController
}

func (page *TicketController) Get() {
	page.O = orm.NewOrm()
	query := []models.Tickets{}
	_, err := page.O.Raw(
		`SELECT  id, train_id, train_name, cabin_type, valid_volume FROM tb_tickets`,
	).QueryRows(&query)

	if err != nil {
		fmt.Println(err.Error())
	} else {
		page.Data["data"] = query
	}

	page.TplName = "admin/ticket/all.html"
}

func (page *TicketController) Post() {

}
