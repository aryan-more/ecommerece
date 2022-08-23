package main

import (
	"aryan.more/ecom/routes"
	"github.com/labstack/echo/v4"
)

func main() {

	e := echo.New()
	routes.AuthRouter(e)
	e.Logger.Fatal(e.Start(":3000"))

}