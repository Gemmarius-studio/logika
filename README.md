# Trenažér výrokovej logiky ako web: návod

Web má dve časti:

- **Supabase** (zadarmo) uchováva účty a postup každého človeka zvlášť.
- **GitHub Pages** (zadarmo) zobrazuje samotnú stránku na adrese typu `https://gemmarius-studio.github.io/logika/`.

Súbory v tomto priečinku:

| súbor | čo to je |
|---|---|
| `index.html` | celá aplikácia |
| `config.js` | adresa a verejný kľúč tvojho Supabase projektu (doplní sa v kroku 1) |
| `nastavenie.sql` | príkazy, ktoré v Supabase vytvoria tabuľku na postup |

---

## 1. Supabase (asi 5 minút, raz)

1. Choď na **supabase.com**, klikni **Start your project** a zaregistruj sa (napr. cez GitHub).
2. **New project**: zadaj názov (napr. `logika`), vymysli heslo k databáze (stačí si ho niekam uložiť, aplikácia ho nepotrebuje) a ako región vyber **Central EU (Frankfurt)**. Klikni **Create new project** a počkaj asi minútu.
3. V ľavom menu otvor **SQL Editor**, klikni **New query**, vlož celý obsah súboru `nastavenie.sql` a klikni **Run**. Má sa ukázať „Success. No rows returned“.
4. Vypni samoregistráciu, aby sa nikto neprihlásil bez teba: **Authentication → Sign In / Providers**, a v časti **User Signups** vypni **Allow new users to sign up**. Ulož.
5. Skopíruj adresu a kľúč: **Project Settings → API Keys** (alebo **Data API**).
   - **Project URL** (napr. `https://abcdefgh.supabase.co`)
   - **anon public** kľúč (začína sa `eyJ…`), prípadne **publishable** kľúč (začína sa `sb_publishable_…`)

   Tieto dva údaje mi pošli, alebo ich vpíš do `config.js`. Kľúč *anon / publishable* je verejný a môže byť na webe, databázu chránia pravidlá z kroku 3. **Kľúč `service_role` (secret) nikomu neposielaj a nikam nevkladaj.**

## 2. Stránka na GitHub Pages

1. Na GitHube vytvor nový **verejný** repozitár, napr. `logika` (**New repository**, Public, bez README).
2. Napíš mi, že existuje. Súbory tam nahrám ja a zapnem GitHub Pages.
3. Web bude na adrese `https://gemmarius-studio.github.io/logika/`.

Ak to chceš nahrať bez mňa: v repozitári **Add file → Upload files**, pretiahni `index.html` a `config.js` a potvrď. Potom **Settings → Pages → Source: Deploy from a branch → main / (root) → Save**. Po minúte je web na uvedenej adrese.

## 3. Pridanie človeka

Keď ti niekto pošle e-mail:

1. Supabase → **Authentication → Users → Add user → Create new user**.
2. Zadaj jeho **e-mail** a **heslo** (aspoň 8 znakov) a zaškrtni **Auto Confirm User**.
3. Pošli mu adresu webu, jeho e-mail a heslo. Heslo si potom môže zmeniť priamo v aplikácii (tlačidlo **Zmeniť heslo** hore).

Nikto sa nemusí registrovať a nikomu nechodia žiadne e-maily.

## 4. Odobratie človeka

Supabase → **Authentication → Users** → pri danom človeku **⋯ → Delete user**. Spolu s účtom sa zmaže aj jeho postup.

## Ako to funguje

- Každý vidí a mení len svoj vlastný postup (levely, štatistiku chýb, náročnosť). Zabezpečujú to pravidlá v databáze, nie len aplikácia.
- Postup vydrží vymazanie prehliadača a je rovnaký na mobile aj počítači.
- Hore pri názve je bodka so stavom: zelená znamená, že sa postup ukladá k účtu.
- Kto klikne **Pokračovať bez prihlásenia**, môže aplikáciu skúsiť, ale postup sa mu ukladá len v prehliadači.
- Ako správca vidíš v Supabase v **Table Editor → progress** surové údaje o postupe všetkých. Bežní používatelia nie.
- Bezplatný Supabase projekt sa po 7 dňoch bez akejkoľvek aktivity pozastaví. Obnovíš ho jedným kliknutím (**Restore**) v Supabase a údaje zostanú zachované.
