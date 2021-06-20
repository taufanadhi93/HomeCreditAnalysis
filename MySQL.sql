{
 "metadata": {
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.8.7"
  },
  "orig_nbformat": 2,
  "kernelspec": {
   "name": "python3",
   "display_name": "Python 3.8.7 64-bit"
  },
  "metadata": {
   "interpreter": {
    "hash": "aee8b7b246df8f9039afb4144a1f6fd8d2ca17a180786b69acc140d282b71a49"
   }
  },
  "interpreter": {
   "hash": "aee8b7b246df8f9039afb4144a1f6fd8d2ca17a180786b69acc140d282b71a49"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2,
 "cells": [
  {
   "source": [
    "## 01. PyMySQL - Student Databases"
   ],
   "cell_type": "markdown",
   "metadata": {}
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import mysql.connector\n",
    "import pandas as pd\n",
    "\n",
    "mydb = mysql.connector.connect(\n",
    "    host = 'localhost',\n",
    "    user = 'root',\n",
    "    passwd = '@Ravenclaw93',\n",
    "    database = 'student_performance'\n",
    ")"
   ]
  },
  {
   "source": [
    "## No. 1"
   ],
   "cell_type": "markdown",
   "metadata": {}
  },
  {
   "cell_type": "code",
   "execution_count": 40,
   "metadata": {},
   "outputs": [
    {
     "output_type": "execute_result",
     "data": {
      "text/plain": [
       "                   name sex avg_age\n",
       "0       Gabriel Pereira   F   16.67\n",
       "1       Gabriel Pereira   M   16.52\n",
       "2  Mousinho da Silveira   M   17.20\n",
       "3  Mousinho da Silveira   F   17.01"
      ],
      "text/html": "<div>\n<style scoped>\n    .dataframe tbody tr th:only-of-type {\n        vertical-align: middle;\n    }\n\n    .dataframe tbody tr th {\n        vertical-align: top;\n    }\n\n    .dataframe thead th {\n        text-align: right;\n    }\n</style>\n<table border=\"1\" class=\"dataframe\">\n  <thead>\n    <tr style=\"text-align: right;\">\n      <th></th>\n      <th>name</th>\n      <th>sex</th>\n      <th>avg_age</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr>\n      <th>0</th>\n      <td>Gabriel Pereira</td>\n      <td>F</td>\n      <td>16.67</td>\n    </tr>\n    <tr>\n      <th>1</th>\n      <td>Gabriel Pereira</td>\n      <td>M</td>\n      <td>16.52</td>\n    </tr>\n    <tr>\n      <th>2</th>\n      <td>Mousinho da Silveira</td>\n      <td>M</td>\n      <td>17.20</td>\n    </tr>\n    <tr>\n      <th>3</th>\n      <td>Mousinho da Silveira</td>\n      <td>F</td>\n      <td>17.01</td>\n    </tr>\n  </tbody>\n</table>\n</div>"
     },
     "metadata": {},
     "execution_count": 40
    }
   ],
   "source": [
    "mycursor = mydb.cursor()\n",
    "query = (\n",
    "    'select school.name, students.sex, round(AVG(students.age),2) as avg_age from school, students where students.school_id = school.id GROUP BY sex, school_id;'\n",
    "    )\n",
    "mycursor.execute(query)\n",
    "result = mycursor.fetchall()\n",
    "ans1 = pd.DataFrame(result, columns=mycursor.column_names)\n",
    "ans1"
   ]
  },
  {
   "source": [
    "## No. 2"
   ],
   "cell_type": "markdown",
   "metadata": {}
  },
  {
   "cell_type": "code",
   "execution_count": 97,
   "metadata": {},
   "outputs": [
    {
     "output_type": "execute_result",
     "data": {
      "text/plain": [
       "   num_of_student\n",
       "0              43"
      ],
      "text/html": "<div>\n<style scoped>\n    .dataframe tbody tr th:only-of-type {\n        vertical-align: middle;\n    }\n\n    .dataframe tbody tr th {\n        vertical-align: top;\n    }\n\n    .dataframe thead th {\n        text-align: right;\n    }\n</style>\n<table border=\"1\" class=\"dataframe\">\n  <thead>\n    <tr style=\"text-align: right;\">\n      <th></th>\n      <th>num_of_student</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr>\n      <th>0</th>\n      <td>43</td>\n    </tr>\n  </tbody>\n</table>\n</div>"
     },
     "metadata": {},
     "execution_count": 97
    }
   ],
   "source": [
    "mycursor = mydb.cursor()\n",
    "query = (\n",
    "    'SELECT count(distinct(student_id)) as num_of_student FROM students, students_family WHERE famsize = 6 AND m_job <> f_job AND sex =\"M\";'\n",
    "    )\n",
    "mycursor.execute(query)\n",
    "result = mycursor.fetchall()\n",
    "ans2 = pd.DataFrame(result, columns=mycursor.column_names)\n",
    "ans2"
   ]
  },
  {
   "source": [
    "## No. 3"
   ],
   "cell_type": "markdown",
   "metadata": {}
  },
  {
   "cell_type": "code",
   "execution_count": 119,
   "metadata": {},
   "outputs": [
    {
     "output_type": "execute_result",
     "data": {
      "text/plain": [
       "                  name  student_id\n",
       "0          Mike Burton     1400105\n",
       "1         Joshua Magee     1400221\n",
       "2       Bernice Seibel     1400262\n",
       "3          Wayne Roach     1400263\n",
       "4          Jesus Field     1400282\n",
       "5      Roger Nicholson     1400293\n",
       "6          Edna Lozano     1400334\n",
       "7    Marlene Donnelson     1400336\n",
       "8        Greta Burrell     1400372\n",
       "9        Dara Spradlin     1400385\n",
       "10      Don Greenfield     1400500\n",
       "11     Cesar Hernandez     1400630\n",
       "12       Alan Simpkins     1400688\n",
       "13       Carrie Bailey     1400697\n",
       "14         Jimmy Mcgee     1400698\n",
       "15     William Facundo     1400722\n",
       "16      Arthur Roberts     1400733\n",
       "17      Julius Gaskill     1400785\n",
       "18      Allison Tsasie     1400848\n",
       "19          Joan Vogel     1400849\n",
       "20        Ollie Martel     1400854\n",
       "21  Catherine Alvarado     1400858\n",
       "22         Marsha Timm     1400870\n",
       "23       Thomas Paneto     1400892\n",
       "24        Mark Miranda     1400897\n",
       "25         Mary Miller     1400902\n",
       "26       Eddie Meltzer     1400922\n",
       "27    Steven Alexander     1400931\n",
       "28        Samantha Faw     1400933\n",
       "29        Jerry Belton    14001023\n",
       "30      Evon Weinzierl    14001036"
      ],
      "text/html": "<div>\n<style scoped>\n    .dataframe tbody tr th:only-of-type {\n        vertical-align: middle;\n    }\n\n    .dataframe tbody tr th {\n        vertical-align: top;\n    }\n\n    .dataframe thead th {\n        text-align: right;\n    }\n</style>\n<table border=\"1\" class=\"dataframe\">\n  <thead>\n    <tr style=\"text-align: right;\">\n      <th></th>\n      <th>name</th>\n      <th>student_id</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr>\n      <th>0</th>\n      <td>Mike Burton</td>\n      <td>1400105</td>\n    </tr>\n    <tr>\n      <th>1</th>\n      <td>Joshua Magee</td>\n      <td>1400221</td>\n    </tr>\n    <tr>\n      <th>2</th>\n      <td>Bernice Seibel</td>\n      <td>1400262</td>\n    </tr>\n    <tr>\n      <th>3</th>\n      <td>Wayne Roach</td>\n      <td>1400263</td>\n    </tr>\n    <tr>\n      <th>4</th>\n      <td>Jesus Field</td>\n      <td>1400282</td>\n    </tr>\n    <tr>\n      <th>5</th>\n      <td>Roger Nicholson</td>\n      <td>1400293</td>\n    </tr>\n    <tr>\n      <th>6</th>\n      <td>Edna Lozano</td>\n      <td>1400334</td>\n    </tr>\n    <tr>\n      <th>7</th>\n      <td>Marlene Donnelson</td>\n      <td>1400336</td>\n    </tr>\n    <tr>\n      <th>8</th>\n      <td>Greta Burrell</td>\n      <td>1400372</td>\n    </tr>\n    <tr>\n      <th>9</th>\n      <td>Dara Spradlin</td>\n      <td>1400385</td>\n    </tr>\n    <tr>\n      <th>10</th>\n      <td>Don Greenfield</td>\n      <td>1400500</td>\n    </tr>\n    <tr>\n      <th>11</th>\n      <td>Cesar Hernandez</td>\n      <td>1400630</td>\n    </tr>\n    <tr>\n      <th>12</th>\n      <td>Alan Simpkins</td>\n      <td>1400688</td>\n    </tr>\n    <tr>\n      <th>13</th>\n      <td>Carrie Bailey</td>\n      <td>1400697</td>\n    </tr>\n    <tr>\n      <th>14</th>\n      <td>Jimmy Mcgee</td>\n      <td>1400698</td>\n    </tr>\n    <tr>\n      <th>15</th>\n      <td>William Facundo</td>\n      <td>1400722</td>\n    </tr>\n    <tr>\n      <th>16</th>\n      <td>Arthur Roberts</td>\n      <td>1400733</td>\n    </tr>\n    <tr>\n      <th>17</th>\n      <td>Julius Gaskill</td>\n      <td>1400785</td>\n    </tr>\n    <tr>\n      <th>18</th>\n      <td>Allison Tsasie</td>\n      <td>1400848</td>\n    </tr>\n    <tr>\n      <th>19</th>\n      <td>Joan Vogel</td>\n      <td>1400849</td>\n    </tr>\n    <tr>\n      <th>20</th>\n      <td>Ollie Martel</td>\n      <td>1400854</td>\n    </tr>\n    <tr>\n      <th>21</th>\n      <td>Catherine Alvarado</td>\n      <td>1400858</td>\n    </tr>\n    <tr>\n      <th>22</th>\n      <td>Marsha Timm</td>\n      <td>1400870</td>\n    </tr>\n    <tr>\n      <th>23</th>\n      <td>Thomas Paneto</td>\n      <td>1400892</td>\n    </tr>\n    <tr>\n      <th>24</th>\n      <td>Mark Miranda</td>\n      <td>1400897</td>\n    </tr>\n    <tr>\n      <th>25</th>\n      <td>Mary Miller</td>\n      <td>1400902</td>\n    </tr>\n    <tr>\n      <th>26</th>\n      <td>Eddie Meltzer</td>\n      <td>1400922</td>\n    </tr>\n    <tr>\n      <th>27</th>\n      <td>Steven Alexander</td>\n      <td>1400931</td>\n    </tr>\n    <tr>\n      <th>28</th>\n      <td>Samantha Faw</td>\n      <td>1400933</td>\n    </tr>\n    <tr>\n      <th>29</th>\n      <td>Jerry Belton</td>\n      <td>14001023</td>\n    </tr>\n    <tr>\n      <th>30</th>\n      <td>Evon Weinzierl</td>\n      <td>14001036</td>\n    </tr>\n  </tbody>\n</table>\n</div>"
     },
     "metadata": {},
     "execution_count": 119
    }
   ],
   "source": [
    "mycursor = mydb.cursor()\n",
    "query = (\n",
    "    'Select students.name, students_profile.student_id from students join students_profile on students.id = students_profile.student_id where students_profile.internet = \"no\" and students_profile.higher_edu = \"yes\" and students_profile.study_time/60 > 5 order by students_profile.student_id;'\n",
    "    )\n",
    "mycursor.execute(query)\n",
    "result = mycursor.fetchall()\n",
    "ans3 = pd.DataFrame(result, columns=mycursor.column_names)\n",
    "ans3"
   ]
  },
  {
   "source": [
    "## No. 4"
   ],
   "cell_type": "markdown",
   "metadata": {}
  },
  {
   "cell_type": "code",
   "execution_count": 148,
   "metadata": {},
   "outputs": [
    {
     "output_type": "execute_result",
     "data": {
      "text/plain": [
       "  occupations  num_of_fathers\n",
       "0     teacher               5"
      ],
      "text/html": "<div>\n<style scoped>\n    .dataframe tbody tr th:only-of-type {\n        vertical-align: middle;\n    }\n\n    .dataframe tbody tr th {\n        vertical-align: top;\n    }\n\n    .dataframe thead th {\n        text-align: right;\n    }\n</style>\n<table border=\"1\" class=\"dataframe\">\n  <thead>\n    <tr style=\"text-align: right;\">\n      <th></th>\n      <th>occupations</th>\n      <th>num_of_fathers</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr>\n      <th>0</th>\n      <td>teacher</td>\n      <td>5</td>\n    </tr>\n  </tbody>\n</table>\n</div>"
     },
     "metadata": {},
     "execution_count": 148
    }
   ],
   "source": [
    "mycursor = mydb.cursor()\n",
    "query = (\n",
    "    'Select max(parent_job.occupation) as occupations, count(distinct(parent_job.occupation)) as num_of_fathers from students_family join parent_job on students_family.m_edu = parent_job.id;'\n",
    "    )\n",
    "mycursor.execute(query)\n",
    "result = mycursor.fetchall()\n",
    "ans4 = pd.DataFrame(result, columns=mycursor.column_names)\n",
    "ans4"
   ]
  },
  {
   "source": [
    "## No. 5"
   ],
   "cell_type": "markdown",
   "metadata": {}
  },
  {
   "cell_type": "code",
   "execution_count": 189,
   "metadata": {},
   "outputs": [
    {
     "output_type": "execute_result",
     "data": {
      "text/plain": [
       "   student_id                name                name\n",
       "0     1400808           Jamie Cox           Jamie Cox\n",
       "1     1400392    Daniel Applegate    Daniel Applegate\n",
       "2     1400969        Brian Theall        Brian Theall\n",
       "3     1400972        Sara Eubanks        Sara Eubanks\n",
       "4     1400350       Gisele Blount       Gisele Blount\n",
       "5     1400353  Matthew Montgomery  Matthew Montgomery\n",
       "6     1400975      Carman Wolcott      Carman Wolcott"
      ],
      "text/html": "<div>\n<style scoped>\n    .dataframe tbody tr th:only-of-type {\n        vertical-align: middle;\n    }\n\n    .dataframe tbody tr th {\n        vertical-align: top;\n    }\n\n    .dataframe thead th {\n        text-align: right;\n    }\n</style>\n<table border=\"1\" class=\"dataframe\">\n  <thead>\n    <tr style=\"text-align: right;\">\n      <th></th>\n      <th>student_id</th>\n      <th>name</th>\n      <th>name</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr>\n      <th>0</th>\n      <td>1400808</td>\n      <td>Jamie Cox</td>\n      <td>Jamie Cox</td>\n    </tr>\n    <tr>\n      <th>1</th>\n      <td>1400392</td>\n      <td>Daniel Applegate</td>\n      <td>Daniel Applegate</td>\n    </tr>\n    <tr>\n      <th>2</th>\n      <td>1400969</td>\n      <td>Brian Theall</td>\n      <td>Brian Theall</td>\n    </tr>\n    <tr>\n      <th>3</th>\n      <td>1400972</td>\n      <td>Sara Eubanks</td>\n      <td>Sara Eubanks</td>\n    </tr>\n    <tr>\n      <th>4</th>\n      <td>1400350</td>\n      <td>Gisele Blount</td>\n      <td>Gisele Blount</td>\n    </tr>\n    <tr>\n      <th>5</th>\n      <td>1400353</td>\n      <td>Matthew Montgomery</td>\n      <td>Matthew Montgomery</td>\n    </tr>\n    <tr>\n      <th>6</th>\n      <td>1400975</td>\n      <td>Carman Wolcott</td>\n      <td>Carman Wolcott</td>\n    </tr>\n  </tbody>\n</table>\n</div>"
     },
     "metadata": {},
     "execution_count": 189
    }
   ],
   "source": [
    "mycursor = mydb.cursor()\n",
    "query = (\n",
    "    'select students_profile.student_id, name, name from students join students_profile on students.id = students_profile.student_id where sex = \"M\" and address <> \"Urban\" order by age desc , num_of_absences desc , free_time desc limit 7;'\n",
    "    )\n",
    "mycursor.execute(query)\n",
    "result = mycursor.fetchall()\n",
    "ans5 = pd.DataFrame(result, columns=mycursor.column_names)\n",
    "ans5"
   ]
  }
 ]
}