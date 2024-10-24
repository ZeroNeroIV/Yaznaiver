package controllers

import (
	"net/http"
	"order-system/initializers"
	"order-system/models"
	"strconv"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
)

func GetOrder(c *gin.Context) {
	id := c.Param("id")

	// Retrieve the order data from the database
	var order models.Order
	if err := initializers.DB.First(&order, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Order not found"})
		return
	}

	// Parse the medicines field
	medicinesMap := parseMedicines(order.Medicines)

	// Prepare a slice to hold the medicines details
	var medicinesDetails []struct {
		GenericName string `json:"generic_name"`
		Quantity    int    `json:"quantity"`
	}

	// Iterate over the medicine IDs and fetch their names from the database
	for medID, qty := range medicinesMap {
		// Define the raw SQL query to fetch the generic name
		var genericName string
		query := "SELECT generic_name FROM medicines WHERE id = ?"

		// Execute the query
		if err := initializers.DB.Raw(query, medID).Scan(&genericName).Error; err == nil {
			medicinesDetails = append(medicinesDetails, struct {
				GenericName string `json:"generic_name"`
				Quantity    int    `json:"quantity"`
			}{
				GenericName: genericName,
				Quantity:    qty,
			})
		}
	}

	// Create a response structure
	response := struct {
		ID         int    `json:"id"`
		CustomerID int    `json:"customer_id"`
		DriverID   int    `json:"driver_id"`
		Status     string `json:"status"`
		Location   string `json:"location"`
		Medicines  []struct {
			GenericName string `json:"generic_name"`
			Quantity    int    `json:"quantity"`
		} `json:"medicines"`
		TotalPrice int       `json:"total_price"`
		OrderDate  time.Time `json:"order_date"`
	}{
		ID:         order.ID,
		CustomerID: order.CustomerID,
		DriverID:   order.DriverID,
		Status:     order.Status,
		Location:   order.Location,
		Medicines:  medicinesDetails,
		TotalPrice: order.TotalPrice,
		OrderDate:  order.OrderDate,
	}

	c.JSON(http.StatusOK, response)
}

// Function to parse the medicines string into a map
func parseMedicines(medicines string) map[int]int {
	medMap := make(map[int]int)
	entries := strings.Split(medicines, ",")
	for _, entry := range entries {
		parts := strings.Split(entry, ":")
		if len(parts) == 2 {
			medID, err := strconv.Atoi(parts[0])
			if err == nil {
				qty, err := strconv.Atoi(parts[1])
				if err == nil {
					medMap[medID] = qty
				}
			}
		}
	}
	return medMap
}

func UpdateOrder(c *gin.Context) {
	id := c.Param("id")
	var order models.Order

	if err := initializers.DB.First(&order, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Order not found"})
		return
	}

	if err := c.ShouldBindJSON(&order); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	initializers.DB.Save(&order)
	c.JSON(http.StatusOK, order)
}

func DeleteOrder(c *gin.Context) {
	id := c.Param("id")

	if err := initializers.DB.Delete(&models.Order{}, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Order not found"})
		return
	}

	c.JSON(http.StatusNoContent, nil)
}

func GetAllOrders(c *gin.Context) {
	var orders []models.Order
	if err := initializers.DB.Find(&orders).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch orders"})
		return
	}

	c.JSON(http.StatusOK, orders)
}

func GetOrdersByCustomer(c *gin.Context) {
	id := c.Param("id")
	var orders []models.Order
	if err := initializers.DB.Where("customer_id = ?", id).Find(&orders).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch orders"})
		return
	}

	c.JSON(http.StatusOK, orders)
}

func CancelOrder(c *gin.Context) {
	id := c.Param("id")
	var order models.Order
	if err := initializers.DB.First(&order, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Order not found"})
		return
	}

	if err := initializers.DB.Model(&order).Update("status", "Cancelled").Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to cancel order"})
		return
	}

	c.JSON(http.StatusOK, order)
}
