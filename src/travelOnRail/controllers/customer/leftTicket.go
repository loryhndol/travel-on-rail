package customer

import (
	"fmt"
	"time"
	"travelOnRail/controllers"
	"travelOnRail/models"

	"github.com/beego/beego/v2/client/orm"
)

type LeftTicketController struct {
	controllers.BaseController
}

type intervalLog struct {
	ArrTime   time.Time
	DeptTime  time.Time
	Beg       string
	Tar       string
	TrainName string
	Distance  int
}

type remainTicketsPerTrain struct {
	ArrClock     [3]int
	DeptClock    [3]int
	Beg          string
	Tar          string
	TrainName    string
	IntervalTime time.Duration
	Distance     int
	ZY           int
	ZE           int
	YW           int
	RW           int
	YZ           int
	None         int
}

func (page *LeftTicketController) Get() {
	page.O = orm.NewOrm()

	// 车站名称
	var stations []string
	num, err := page.O.Raw("SELECT station_name from tb_office").QueryRows(&stations)
	if err != nil {
		fmt.Println(err.Error())
	} else {
		page.Data["num"] = num
		page.Data["fs"] = stations
		page.Data["ts"] = stations
	}

	fromStation := page.GetString("fs")
	toStation := page.GetString("ts")

	// departure := page.GetString("departTime")

	if fromStation != "" && toStation != "" {
		// 找到车站的城市拥有的所有车站
		var deptStations []string
		_, err := page.O.Raw(
			`SELECT station_name FROM tb_office 
			WHERE city_name = (
				SELECT city_name FROM tb_office WHERE station_name = ?
				)`,
			fromStation,
		).QueryRows(&deptStations)

		if err != nil {
			fmt.Println(err.Error())
		}

		var arrStations []string
		page.O.Raw(
			`SELECT station_name FROM tb_office 
			WHERE city_name = (
				SELECT city_name FROM tb_office WHERE station_name = ?
				)`,
			toStation,
		).QueryRows(&arrStations)

		// 寻找所有可能的配对

		fromLog := []*models.TrainLog{}
		qs := page.O.QueryTable("tb_train_log")

		qs.Distinct().Filter("station_name__in", deptStations).All(&fromLog)

		toLog := []*models.TrainLog{}
		qs = page.O.QueryTable("tb_train_log")

		qs.Distinct().Filter("station_name__in", arrStations).All(&toLog)

		var ansLog []intervalLog
		var leftTickets []remainTicketsPerTrain

		for _, i := range fromLog {
			for _, j := range toLog {
				// fmt.Println(j.StationName, " ", j.TrainName, " ", j.KmMark)
				// fmt.Println(i.StationName, " ", i.TrainName, " ", i.KmMark)
				if i.TrainName == j.TrainName && i.KmMark < j.KmMark {
					var ans intervalLog
					ans.ArrTime = j.ArrTime
					ans.DeptTime = i.DeptTime
					ans.Beg = i.StationName
					ans.Tar = j.StationName
					ans.Distance = j.KmMark - i.KmMark
					ans.TrainName = i.TrainName
					sign := false
					for _, v := range ansLog {
						if v.TrainName == ans.TrainName {
							sign = true
							break
						}
					}
					if !sign {
						ansLog = append(ansLog, ans)
						remainTickets := []*models.Remainders{}
						page.O.Raw(
							`SELECT station_name, cabin_type, valid_volume FROM view_remaining_tickets 
							WHERE train_name = ? and station_name in (?)`,
							ans.TrainName, ans.Beg,
						).QueryRows(&remainTickets)

						var curTrainTickets remainTicketsPerTrain

						curTrainTickets.TrainName = ans.TrainName
						curTrainTickets.ArrClock[0], curTrainTickets.ArrClock[1], curTrainTickets.ArrClock[2] = ans.ArrTime.Local().Clock()
						curTrainTickets.DeptClock[0], curTrainTickets.DeptClock[1], curTrainTickets.DeptClock[2] = ans.DeptTime.Local().Clock()
						curTrainTickets.Distance = ans.Distance
						curTrainTickets.Beg = ans.Beg
						curTrainTickets.Tar = ans.Tar
						curTrainTickets.IntervalTime = ans.ArrTime.Sub(ans.DeptTime)

						for _, v := range remainTickets {
							if v.StationName == ans.Beg {
								switch v.CabinType {
								case "ZY":
									curTrainTickets.ZY = v.ValidVolume
								case "ZE":
									curTrainTickets.ZE = v.ValidVolume
								case "RW":
									curTrainTickets.RW = v.ValidVolume
								case "YW":
									curTrainTickets.YW = v.ValidVolume
								case "YZ":
									curTrainTickets.YZ = v.ValidVolume
								case "None":
									curTrainTickets.None = v.ValidVolume
								}

							}
						}

						leftTickets = append(leftTickets, curTrainTickets)
					}

				}
			}
		}

		page.Data["leftTicket"] = leftTickets

	}

	page.TplName = "customer/leftTicket.html"
}

func (page *LeftTicketController) Post() {

	page.TplName = "customer/leftTicket.html"
}
