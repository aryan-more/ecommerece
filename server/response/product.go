package response

import "aryan.more/ecom/models"

type ProductSearchResponse struct {
	Products []models.Product `json:"products"`
}
