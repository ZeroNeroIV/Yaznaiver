package controllers

import (
	"fmt"
	"net/http"
	"time"

	"order-system/initializers"
	"order-system/models"

	"github.com/gin-gonic/gin"
)

func CreateOrder(c *gin.Context) {
	var order models.Order

	type input struct {
		CustomerID int         `json:"customer_id"`
		Medicines  map[int]int `json:"medicines"` // Expecting a map from the client
		OrderDate  time.Time   `json:"order_date"`
		TotalPrice int         `json:"total_price"`
	}

	var inputData input
	if err := c.ShouldBindJSON(&inputData); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	order.CustomerID = inputData.CustomerID
	order.OrderDate = inputData.OrderDate
	order.TotalPrice = inputData.TotalPrice

	//  default values
	order.DriverID = 1
	order.Status = "in progress"
	order.Location = "d"

	medicinesStr := ""
	for id, quantity := range inputData.Medicines {
		if medicinesStr != "" {
			medicinesStr += "," // Add comma before appending new entry
		}
		medicinesStr += fmt.Sprintf("%d:%d", id, quantity) // Format as "id:quantity"
	}
	order.Medicines = medicinesStr // Set the combined string to the Medicines field

	if err := initializers.DB.Create(&order).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create order"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Order created successfully", "order": order})
}
