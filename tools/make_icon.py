"""雀とも！配布用アプリアイコン（1024px）を作るスクリプト。
Pillow でフラットデザインの麻雀牌（白牌に色リング模様）を描く。生成物:
  - app/assets/icon/app_icon.png      （flutter_launcher_icons のソース）
"""
from PIL import Image, ImageDraw

SIZE = 1024
BG = (232, 236, 242)        # ライトグレー（シリーズ共通の落ち着いた背景色）
TILE = (250, 250, 250)      # 牌本体（白）
EDGE = (46, 58, 74)         # 牌の縁・影（ダークネイビー）
DRAGON = (39, 143, 90)      # 緑の模様（ドラゴン牌風）
ACCENT = (239, 68, 68)      # 赤の模様（赤牌アクセント）


def rounded(im: Image.Image, radius: int) -> Image.Image:
    mask = Image.new("L", im.size, 0)
    d = ImageDraw.Draw(mask)
    d.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=radius, fill=255)
    out = Image.new("RGBA", im.size, (0, 0, 0, 0))
    out.paste(im, (0, 0), mask)
    return out


def draw_tile():
    im = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)

    # 背景（角丸ライトグレー）
    d.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=192, fill=BG + (255,))

    # 奥の緑牌（右上寄り）: 影→本体→模様
    d.rounded_rectangle([262, 198, 662, 796], radius=64, fill=EDGE + (255,))
    d.rounded_rectangle([242, 172, 642, 772], radius=64, fill=TILE + (255,))
    d.arc([352, 372, 532, 552], start=0, end=360, fill=DRAGON + (255,), width=36)
    d.ellipse([412, 432, 472, 492], fill=DRAGON + (255,))

    # 手前の赤牌（左下に重ねる）: 影→本体→模様
    d.rounded_rectangle([138, 424, 398, 822], radius=48, fill=EDGE + (255,))
    d.rounded_rectangle([118, 402, 378, 800], radius=48, fill=TILE + (255,))
    d.arc([168, 508, 328, 668], start=0, end=360, fill=ACCENT + (255,), width=28)
    d.ellipse([215, 555, 281, 621], fill=ACCENT + (255,))

    return im


if __name__ == "__main__":
    im = draw_tile()
    im = rounded(im, 192)
    out = r"..\app\assets\icon\app_icon.png"
    im.save(out)
    print("saved:", out)
