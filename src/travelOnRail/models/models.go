package models

import (
	"time"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/server/web"
)

func Init() {
	dbhost, _ := web.AppConfig.String("dbhost")
	dbport, _ := web.AppConfig.String("dbport")
	dbuser, _ := web.AppConfig.String("dbuser")
	dbpassword, _ := web.AppConfig.String("dbpassword")
	dbname, _ := web.AppConfig.String("dbname")
	if dbport == "" {
		dbport = "3306"
	}
	dsn := dbuser + ":" + dbpassword + "@tcp(" + dbhost + ":" + dbport + ")/" + dbname + "?charset=utf8&loc=Asia%2FShanghai"
	orm.RegisterDriver("mysql", orm.DRMySQL)
	orm.RegisterDataBase("default", "mysql", dsn)
	orm.RegisterModelWithPrefix("tb_", new(UserAccount), new(Tickets), new(TrainLog), new(Orders), new(UserOrders), new(Office))
}

type Office struct {
	CityName    string `orm:size(16)`
	Id          int
	StationName string `orm:size(16)`
}

type Orders struct {
	ArrStation  string `orm:"size(16)"`
	ArrTime     time.Time
	DeptStation string `orm:"size(16)"`
	DeptTime    time.Time
	Id          int
	TicketId    int
	TrainName   string `orm:"size(16)"`
}

type UserOrders struct {
	CreatedAt   time.Time
	Id          int
	OrderId     int
	OrderStatus int
	UserCode    int
}

type TrainLog struct {
	ArrTime     time.Time
	CityId      int
	DeptTime    time.Time
	Id          int
	KmMark      int
	StationName string `orm:"size(16)"`
	TrainName   string `orm:"size(16)"`
}

type Tickets struct {
	CabinType   string `orm:"size(16)"`
	Id          int
	TrainId     int
	TrainName   string `orm:"size(16)"`
	ValidVolume int
}

type UserAccount struct {
	Age          int
	Balance      float32
	CreatedAt    time.Time
	CreatedIp    int
	Id           int
	IdentityCode string `orm:"size(255)"`
	Name         string `orm:"size(45)"`
	Passwd       string `orm:"size(255)`
	UserName     string `orm:"size(20)"`
}

type CityStations struct {
	City    string
	Station string
}

type Remainders struct {
	StationName string
	CabinType   string
	ValidVolume int
}
