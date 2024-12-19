package routes

import (
	"order-system/controllers"
	"order-system/graphql"

	"github.com/gin-gonic/gin"
)

func SetupRoutes() *gin.Engine {
	r := gin.Default()

	r.GET("/orders/:id", controllers.GetOrder)
	r.PUT("/orders/:id", controllers.UpdateOrder)
	r.DELETE("/orders/:id", controllers.DeleteOrder)
	r.GET("/orders", controllers.GetAllOrders)
	r.GET("/ordersCustomer/:id", controllers.GetOrdersByCustomer)
	r.PUT("/orders/:id/cancel", controllers.CancelOrder)

	graphql.SetupGraphQLRoutes(r)
	graphql.SetupGraphQLRoutes2(r)

	r.POST("/createOrder", controllers.CreateOrder)

	return r
}
