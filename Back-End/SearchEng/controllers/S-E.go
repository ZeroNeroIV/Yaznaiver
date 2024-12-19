package controllers

import (
	"net/http"
	"search-engine/initializers"
	"search-engine/models"

	"github.com/gin-gonic/gin"
)

func GetMedicines(c *gin.Context) {
	id := c.Param("id")
	var med models.Medicines
	if err := initializers.DB.First(&med, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Medicine not found"})
		return
	}
	c.JSON(http.StatusOK, med)
}

func GetMedicine(c *gin.Context) {
	id := c.Param("id")
	var med models.Medicines
	if err := initializers.DB.First(&med, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Medicine not found"})
		return
	}
	c.JSON(http.StatusOK, med)
}
