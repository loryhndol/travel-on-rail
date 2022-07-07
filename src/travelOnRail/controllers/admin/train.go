package admin

import (
	"fmt"
	"time"

	"travelOnRail/controllers"

	"github.com/beego/beego/v2/client/orm"
)

type stationInfo struct {
	City string
	Cnt  int
}

type stationTraffic struct {
	Arrival time.Time
	Cnt     int
}

type TrainController struct {
	controllers.BaseController
}

func (train *TrainController) Get() {
	train.O = orm.NewOrm()

	/* 车站数量图 */
	var info []stationInfo
	num, err := train.O.Raw("SELECT city, count(station) as cnt FROM view_city_stations GROUP BY city").QueryRows(&info)

	if err == nil {
		fmt.Println("info nums: ", num)

		// for i, v := range info {
		// 	fmt.Printf("Index: %d city: %s num of stations: %d\n", i, v.City, v.Cnt)
		// }
	}

	train.Data["city_stations"] = &info

	/* 车站车次图 */
	var station_name = "山海关"
	var traffic []stationTraffic
	num, err = train.O.Raw("SELECT arr_time, count(train_name) as cnt FROM view_remaining_tickets WHERE station_name = ? GROUP BY arr_time", station_name).QueryRows(&traffic)

	if err == nil {
		fmt.Println("info nums: ", num)
		for i, v := range traffic {
			fmt.Printf("Index: %d time: %s num of trains: %d\n", i, v.Arrival, v.Cnt)
		}
	}

	train.Data["station_traffic"] = &traffic

	train.TplName = "admin/train/index.html"
}

func (train *TrainController) Post() {

}
