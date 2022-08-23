package response

import (
	"aryan.more/ecom/models"
	"aryan.more/ecom/utils"
	"github.com/labstack/echo/v4"
)

type AuthResponse struct {
	TOKEN string `json:"token"`
}

func ClientCredential(user models.User) (echo.Map, error) {
	token, err := utils.GetJWT(user.ID)
	if err != nil {
		return nil, err
	}
	return echo.Map{"token": token, "email": user.EMAIL, "phone": user.PHONE, "name": user.NAME, "cart": []int{}}, nil
}
