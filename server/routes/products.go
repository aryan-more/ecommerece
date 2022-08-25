package routes

import (
	"aryan.more/ecom/routes_logic"
	"github.com/labstack/echo/v4"
)

func ProductRouter(e *echo.Echo) {
	e.GET("/products", routes_logic.GetProducts)
	e.GET("/product", routes_logic.SearchProduct)
}
