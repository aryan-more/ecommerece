package routes

import (
	"aryan.more/ecom/middleware"
	"aryan.more/ecom/routes_logic"
	"github.com/labstack/echo/v4"
)

func CartRouter(e *echo.Echo) {
	e.POST("/cart", routes_logic.UpdateCart, middleware.TokenMiddleware)

}
