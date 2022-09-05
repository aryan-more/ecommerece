package middleware

import (
	"net/http"

	"aryan.more/ecom/response"
	"aryan.more/ecom/utils"
	"github.com/labstack/echo/v4"
)

func TokenMiddleware(next echo.HandlerFunc) echo.HandlerFunc {

	return func(c echo.Context) error {
		token := c.Request().Header.Get("token")

		if token == "" {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Unauthorized"})
		}

		id, err := utils.GetIdJWT(token)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: err.Error()})
		}

		c.QueryParams().Set("id", id)

		return next(c)
	}
}
