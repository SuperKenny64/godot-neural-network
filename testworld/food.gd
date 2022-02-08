extends StaticBody2D

func interaction(ref):
	print("eat")
	if ref.stats.material <= 80 * ref.hungermulti:
		ref.stats.material += 20
		ref.stats.symp += 25
		if ref.stats.material >= 80 * ref.hungermulti:
			ref.hungry = 0
	queue_free()
