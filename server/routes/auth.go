package routes

import (
	"aryan.more/ecom/middleware"
	"aryan.more/ecom/routes_logic"
	"github.com/labstack/echo/v4"
)

func AuthRouter(e *echo.Echo) {
	e.POST("/signup", routes_logic.SignUp)
	e.POST("/signin", routes_logic.SignIn)
	e.GET("/info", routes_logic.UpdatedUserInfo, middleware.TokenMiddleware)
}
