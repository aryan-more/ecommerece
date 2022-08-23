package middleware

import (
	"net/http"

	"aryan.more/ecom/models"
	"aryan.more/ecom/response"
	"aryan.more/ecom/utils"
	"github.com/labstack/echo/v4"
)

func TokenMiddleware(next echo.HandlerFunc) echo.HandlerFunc {

	return func(c echo.Context) error {

		var token models.Token
		err := c.Bind(token)
		if err != nil || token.TOKEN == "" {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: "Invalid body"})
		}

		id, err := utils.GetIdJWT(token.TOKEN)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse{Msg: err.Error()})
		}

		c.QueryParams().Add("id", id)

		return next(c)
	}
}
