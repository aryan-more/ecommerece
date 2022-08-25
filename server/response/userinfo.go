package response

type UpdatedUserInfo struct {
	NAME  string `json:"name,omitempty"`
	EMAIL string `json:"email,omitempty"`
	PHONE string `json:"phone,omitempty"`
	CART  []int  `json:"cart"`
}
