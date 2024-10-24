package models

import (
	"time"
)

type Order struct {
	ID         int       `json:"id"`
	CustomerID int       `json:"customer_id"`
	DriverID   int       `json:"driver_id"` 
	Status     string    `json:"status"`    
	Location   string    `json:"location"`  
	Medicines  string    `json:"medicines"` 
	TotalPrice int       `json:"total_price"`
	OrderDate  time.Time `json:"order_date"`
}
